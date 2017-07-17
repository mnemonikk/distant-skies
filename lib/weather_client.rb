require 'rest-client'
require 'uri'
require 'rack/utils'
require 'json'

class WeatherClient
  module ResultNotFound
    def self.to_s
      "City not found"
    end
  end

  module NoResult
    def self.to_s
      "We've had a problem."
    end
  end

  class Result
    def initialize(weather_data)
      @weather_data = weather_data
    end

    def to_s
      "#{description}, #{temp}°C, #{pressure} hPa, #{humidity}% humidity"
    end

    def description
      weather_data['weather'].map { |weather| weather['description'] }.join(", ")
    end

    def temp
      weather_data.dig('main', 'temp')
    end

    def pressure
      weather_data.dig('main', 'pressure')
    end

    def humidity
      weather_data.dig('main', 'humidity')
    end

    private

    attr_reader :weather_data
  end

  BASE_URI = "http://api.openweathermap.org/data/2.5/weather"

  def self.instance
    @instance ||= new(
      Moneta.new(
        :YAML,
        file: Rails.root.join('tmp', 'cache', 'weather_data.yml'),
        expires: 300
      )
    )
  end

  def initialize(cache = Moneta.new(:LRUHash), http_client = RestClient)
    @cache = cache
    @http_client = http_client
  end

  def current(location, country = nil)
    cache.fetch([location, country]) {
      cache[[location, country]] = get_current(location, country)
    }
  end

  private

  attr_reader :cache, :http_client

  def get_current(location, country)
    uri = URI(BASE_URI)
    uri.query = Rack::Utils.build_query(
      appid: ENV.fetch('APPID'),
      units: 'metric',
      q: [location, country].compact.join(',')
    )
    response = http_client.get(uri.to_s)
    Result.new(JSON.parse(response.body))
  rescue RestClient::NotFound
    ResultNotFound
  rescue RestClient::Exception
    NoResult
  end
end
