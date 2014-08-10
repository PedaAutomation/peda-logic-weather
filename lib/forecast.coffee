Forecast = require 'forecast.io'
request = require 'request'

options = {
  APIKey: process.env.FORECAST_API_KEY
}

daysOfWeek = {
  monday: 1
  tuesday: 2
  wednesday: 3
  thursday: 4
  friday: 5
  saturday: 6
  sunday: 7  
}

defaultPlace = process.env.DEFAULT_WEATHER_PLACE

forecast = new Forecast options


getCoordinatesFromPlace = (place, cb) ->  
  url = "http://maps.google.com/maps/api/geocode/json?address=#{encodeURIComponent(place)}&sensor=false"
  request {url: url, json: true}, (err, response, body) ->   
    cb body.results[0].geometry.location

#TODO: test if this works
getDateOfDay = (dayOfWeek) ->
  if dayOfWeek is "today" then return new Date()
    
  dayOfWeek = daysOfWeek[dayOfWeek]
  
  val = dayOfWeek - (new Date().getDay())
  if val < 0 then val += 7
  date = new Date()
  date = new Date(date.getFullYear(), date.getMonth(), date.getDate() + val + 1)  


predictWeather = (language, helper) ->
  predictWeatherIn language, defaultPlace, "today"  


predictWeatherIn = (language, place, time, helper) ->  
  
  queryOptions = {
    lang: language
    units: "si"
  }  
  
  date = getDateOfDay time
  
  getCoordinatesFromPlace place, (location) ->
    forecast.getAtTime location.lat, location.lng, Math.floor(date.getTime()/1000), queryOptions, (err, res, data) ->
     
      if err then throw err
      data.currently.summary + helper.__("predictConnection") + data.currently.temperature + helper.__("degrees")


module.exports.predictWeather = predictWeather
module.exports.predictWeatherIn = predictWeatherIn
