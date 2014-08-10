forecast = require './forecast.coffee'

defaultPlace = process.env.DEFAULT_WEATHER_PLACE

german = require './i18n/de.json'
english = require './i18n/en.json'


weatherNowHere = (data) ->
  command = data.capability.split(":")[1]
  input = data.command
  output = forecast.predictWeather language, slave
  slave.sendOutputToCapability(output, "tts")

weatherThenHere = (data) ->
  command = data.capability.split(":")[1]
  input = data.command
  regex = slave.__(command)
  output = forecast.predictWeatherIn language, defaultPlace, regex.exec(input)[1], slave
  slave.sendOutputToCapability(output, "tts")

weatherNow = (data) ->
  command = data.capability.split(":")[1]
  input = data.command
  regex = slave.__(command)  
  output = forecast.predictWeatherIn language, regex.exec(input)[2], "today", slave
  slave.sendOutputToCapability(output, "tts") 

weatherThen = (data) ->
  command = data.capability.split(":")[1]
  input = data.command
  regex = slave.__(command)
  output = forecast.predictWeatherIn language, regex.exec(input)[2], regex.exec(input)[1], slave
  slave.sendOutputToCapability(output, "tts")

module.exports = (slave) ->
  
  language = slave.getLanguage
  
  slave.setType "logic"
  slave.setName "weather"
  
  slave.registerLanguage "en", english, true
  slave.registerLanguage "de", german

  slave.registerLogic "weatherNowHere", slave.__("weatherNowHere"), weatherNowHere
  slave.registerLogic "weatherThenHere", slave.__("weatherThenHere"), weatherThenHere
  slave.registerLogic "weatherThen", slave.__("weatherThen"), weatherThen 
  slave.registerLogic "weatherNow", slave.__("weatherNow"), weatherNowHere


 
  
    
       
