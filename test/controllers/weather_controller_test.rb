# test/controllers/weather_controller_test.rb
require 'test_helper'

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weather_index_url
    assert_response :success
  end

  test "should display a form for entering ZIP code" do
    get weather_index_url
    assert_select "input[type='text'][name='zip_code']"
    assert_select "input[type='submit'][value='Get Forecast']"
  end

  test "should display forecast data when provided with a valid ZIP code" do
    get weather_index_url, params: { zip_code: '90210' }
    assert_response :success

    assert_select "h2", text: "Current Weather:"
    assert_select "p", text: /Forecast:/
    assert_select "p", text: /Temperature:/
    assert_select "p", text: /Feels Like:/
  end

  test "should display an error message for an invalid ZIP code" do
    get weather_index_url, params: { zip_code: 'invalid_zip_code' }
    assert_response :success
    assert_select "p", text: "Location not found for the provided ZIP code."
  end
end

