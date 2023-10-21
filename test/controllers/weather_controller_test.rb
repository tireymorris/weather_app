require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get forecast for a valid ZIP code" do
    get weather_index_path(zip_code: "90210")
    assert_response :success
    assert_select "p", "Forecast:"
  end
end

