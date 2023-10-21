# app/controllers/weather_controller.rb
require 'net/http'
require 'json'

class WeatherController < ApplicationController
  def index
    zip_code = params[:zip_code]
    if zip_code.present?
      api_key = ENV['WEATHER_API_KEY']
      url = "https://api.openweathermap.org/data/3.0/onecall?zip=#{zip_code}&appid=#{api_key}"
      
      response = Net::HTTP.get(URI(url))
      data = JSON.parse(response)
      
      puts 'API KEY: ', api_key
      puts 'DATA:', data
      
      if data['main']
        temperature = data['main']['temp']
        @forecast = "Current Temperature: #{temperature}°F"
      else
        @forecast = "Forecast not available for this ZIP code."
      end
    else
      @forecast = "Enter a ZIP code to get the forecast."
    end
  end
end

