# README

## Deployment

Deployed using the built-in Rails server and Caddy as a reverse proxy, at https://weather.tirey.me

## Usage
`WEATHER_API_KEY=<YOUR_API_KEY> rails server`


### Further information
Everything here should be standard for a Rails app.
I haven't really done any domain modeling here, just a simple cache on top of the OpenWeatherMap API.

See `WeatherController` and its corresponding view file for the full implementation.
