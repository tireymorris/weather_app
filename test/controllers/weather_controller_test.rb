require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should display an error message for an invalid ZIP code" do
    get weather_index_path(zip_code: "")
    assert_response :success
    assert_select "p", "Location not found for the provided ZIP code."
  end
end

