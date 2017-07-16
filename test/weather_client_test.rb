require "test_helper"

class WeatherClientTest < ActiveSupport::TestCase
  def test_current
    client = WeatherClient.new
    assert_nil client.current('bötzow')
  end
end
