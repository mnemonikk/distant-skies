class WeatherQueriesController < ActionController::Base
  def new
    @weather_query = WeatherQuery.new
  end

  def create
    @weather_query = WeatherQuery.new(
      params.require(:weather_query).permit(:location, :country)
    )

    render 'new' unless @weather_query.valid?

    @result = WeatherClient.instance.current(
      @weather_query.location,
      @weather_query.country.presence
    )
  end
end
