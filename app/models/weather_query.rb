class WeatherQuery
  include ActiveModel::Model
  attr_accessor :location, :country

  validates :country, inclusion: { in: CountryCollection.instance.codes }
end
