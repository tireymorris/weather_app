require 'net/http'
require 'json'

class WeatherController < ApplicationController
  def index
    zip_code = params[:zip_code]
    return @forecast = "Enter a ZIP code to get the forecast." unless zip_code.present?
    # Check if the forecast is already cached
    @cached_result = Rails.cache.fetch(zip_code)
    return @forecast = @cached_result if @cached_result.present?

    api_key = ENV['WEATHER_API_KEY']

    # Step 1: Geocoding API call to retrieve latitude and longitude
    geocoding_url = "http://api.openweathermap.org/geo/1.0/zip?zip=#{zip_code},US&appid=#{api_key}"
    geocoding_response = Net::HTTP.get(URI(geocoding_url))
    geocoding_data = JSON.parse(geocoding_response)
  
    return @forecast = "Location not found for the provided ZIP code." unless geocoding_data['lat'] && geocoding_data['lon']

    # Step 2: Forecast API call using latitude and longitude
    lat = geocoding_data['lat']
    lon = geocoding_data['lon']
    forecast_url = "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat}&lon=#{lon}&exclude=minutely,hourly,alerts&appid=#{api_key}&units=imperial"
    forecast_response = Net::HTTP.get(URI(forecast_url))
    forecast_data = JSON.parse(forecast_response)

    return @forecast = "Forecast not available for this location." unless forecast_data['current']

    @forecast = forecast_data

    # Cache the forecast and alerts for 30 minutes
    Rails.cache.write(zip_code, @forecast, expires_in: 30.minutes)
  end
end

