# Weather Logic Module for Peda Automation

This module uses the forecast.io api to gather information about the weather.

## Receiving an API-Key
The weather plugin needs a forecast.io api key. You can get one [here](https://developer.forecast.io/). Very awesome: You have 1,000 free api calls per day. 

## Setting up the plugin (will change soon)
Install the plugin on your slave as usual und set the environment variable __FORECAST_API_KEY__ to your api key.
You may also set __DEFAULT_WEATHER_PLACE__ to your home location.

## Commands
You can find the exact commands for your language in /lib/i18n/yourlng.json
* How is the weather? - Returns the current weather (short summary and temperature) at __DEFAULT_WEATHER_PLACE__
* What is the weather on (day of week)? - Returns a prediction of weather at __DEFAULT_WEATHER_PLACE__
* What is the weather in (place)? - Returns the current weather at the specified place.
* What is the weather on (day of week) in (place)? - Returns a prediction of weather at the specified place.

Example: What is the weather on monday in Frankfurt? 
The answer will be something like: Partly cloudy at 14.54 °C
