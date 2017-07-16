require 'rails_helper'

RSpec.describe WeatherClient do
  subject(:client) { described_class.new(cache, http_client) }

  let(:cache) { {} }
  let(:http_client) {
    double('http_client').tap do |http_client|
      allow(http_client).to receive(:get).with(/#{Rack::Utils.escape('bötzow')}/).and_return(response_for_boetzow)
      allow(http_client).to receive(:get).with(/wilhelmshaven/).and_return(response_for_wilhelmshaven)
    end
  }

  let(:response_for_boetzow) {
    double('response', body: JSON.dump(weather_data_boetzow), status: 200)
  }
  let(:response_for_wilhelmshaven) {
    double('response', body: JSON.dump(weather_data_wilhelmshaven), status: 200)
  }

  let(:weather_data_boetzow) {
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

  let(:weather_data_wilhelmshaven) {
    {"coord"=>{"lon"=>8.13, "lat"=>53.52},
     "weather"=>
     [{"id"=>803,
       "main"=>"Clouds",
       "description"=>"broken clouds",
       "icon"=>"04n"}],
     "base"=>"stations",
     "main"=>
     {"temp"=>16.66,
      "pressure"=>1021,
      "humidity"=>93,
      "temp_min"=>16,
      "temp_max"=>17},
     "visibility"=>10000,
     "wind"=>{"speed"=>2.1, "deg"=>280},
     "clouds"=>{"all"=>75},
     "dt"=>1500234600,
     "sys"=>
     {"type"=>1,
      "id"=>4894,
      "message"=>0.0021,
      "country"=>"DE",
      "sunrise"=>1500175198,
      "sunset"=>1500234387},
     "id"=>2808720,
     "name"=>"Wilhelmshaven",
     "cod"=>200}
  }

  it 'returns local weather data' do
    result = client.current('bötzow')
    expect(result.temp).to eq(18.53)
    expect(result.pressure).to eq(1020)
    expect(result.humidity).to eq(77)
  end

  it 'uses the cache for subsequent queries' do
    expect(http_client).to receive(:get).twice

    client.current('bötzow')
    client.current('wilhelmshaven')
    result = client.current('bötzow')
    expect(result.temp).to eq(18.53)
    expect(result.pressure).to eq(1020)
    expect(result.humidity).to eq(77)
  end
end
