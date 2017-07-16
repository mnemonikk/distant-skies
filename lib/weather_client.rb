require 'rest-client'
require 'uri'
require 'rack/utils'
require 'json'

class WeatherClient
  BASE_URI = "http://api.openweathermap.org/data/2.5/weather"

  def initialize(http_client = RestClient)
    @http_client = http_client
  end

  def current(location)
    uri = URI(BASE_URI)
    uri.query = Rack::Utils.build_query(
      appid: ENV.fetch('APPID'),
      units: 'metric',
      q: location
    )
    response = http_client.get(uri.to_s)
    JSON.parse(response.body)
  end

  private

  attr_reader :http_client
end
