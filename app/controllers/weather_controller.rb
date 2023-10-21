require 'net/http'
require 'json'

class WeatherController < ApplicationController
  def index
    zip_code = params[:zip_code]
    return @forecast = "Enter a ZIP code to get the forecast." unless zip_code.present?

    api_key = ENV['WEATHER_API_KEY']

    geocoding_url = "http://api.openweathermap.org/geo/1.0/zip?zip=#{zip_code},US&appid=#{api_key}"
    geocoding_response = Net::HTTP.get(URI(geocoding_url))
    geocoding_data = JSON.parse(geocoding_response)
    
    return @forecast = "Location not found for the provided ZIP code." unless geocoding_data['lat'] && geocoding_data['lon']

    lat = geocoding_data['lat']
    lon = geocoding_data['lon']
    forecast_url = "https://api.openweathermap.org/data/3.0/onecall?lat=#{lat}&lon=#{lon}&exclude=hourly,daily&appid=#{api_key}"
    forecast_response = Net::HTTP.get(URI(forecast_url))
    forecast_data = JSON.parse(forecast_response)

    return @forecast = "Forecast not available for this location." unless forecast_data['current']

    temperature = forecast_data['current']['temp']
    @forecast = "Current Temperature: #{temperature}°F"
  end
end

