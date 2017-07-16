class WeatherQueriesController < ActionController::Base
  def new
    @weather_query = WeatherQuery.new
  end

  def create
    @weather_query = WeatherQuery.new(
      params.require(:weather_query).permit(:location, :country)
    )

    @client = WeatherClient.instance
  end
end
