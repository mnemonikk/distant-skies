require 'rails_helper'

RSpec.describe WeatherClient do
  subject(:client) { described_class.new(http_client) }

  let(:http_client) { double('http_client', get: response) }
  let(:response) {
    double('response', body: JSON.dump(weather_data), status: 200)
  }
  let(:weather_data) {
    {"coord"=>{"lon"=>13.13, "lat"=>52.63},
     "weather"=>
     [{"id"=>803,
       "main"=>"Clouds",
       "description"=>"broken clouds",
       "icon"=>"04d"}],
     "base"=>"stations",
     "main"=>
     {"temp"=>18.53,
      "pressure"=>1020,
      "humidity"=>77,
      "temp_min"=>18,
      "temp_max"=>19},
     "visibility"=>10000,
     "wind"=>{"speed"=>2.6, "deg"=>180},
     "clouds"=>{"all"=>75},
     "dt"=>1500229200,
     "sys"=>
     {"type"=>1,
      "id"=>4892,
      "message"=>0.0028,
      "country"=>"DE",
      "sunrise"=>1500174274,
      "sunset"=>1500232913},
     "id"=>2945737,
     "name"=>"Bötzow",
     "cod"=>200}
  }

  it 'returns local weather data' do
    result = client.current('bötzow')
    expect(result.temp).to eq(18.53)
    expect(result.pressure).to eq(1020)
    expect(result.humidity).to eq(77)
  end
end
