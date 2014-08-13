forecast = require './forecast.coffee'

defaultPlace = process.env.DEFAULT_WEATHER_PLACE

german = require './i18n/de.json'
english = require './i18n/en.json'

language = null

weatherNowHere = (data, slave) ->
  command = data.capability.split(":")[1]
  output = forecast.predictWeather(language, slave, (output) ->
    slave.sendOutputToCapability(output, "tts")
  )

weatherThenHere = (data, slave) ->
  command = data.capability.split(":")[1]
  input = data.command.command
  regex = slave.__regex(command)
  output = forecast.predictWeatherIn(language, defaultPlace, regex.exec(input)[1], slave, (output) ->
    slave.sendOutputToCapability(output, "tts")
  )

weatherNow = (data, slave) ->
  command = data.capability.split(":")[1]
  input = data.command.command
  regex = slave.__regex(command)  
  output = forecast.predictWeatherIn(language, regex.exec(input)[1], "today", slave, (output) ->
    slave.sendOutputToCapability(output, "tts")
  )

weatherThen = (data, slave) ->
  command = data.capability.split(":")[1]
  input = data.command.command
  regex = slave.__regex(command)
  output = forecast.predictWeatherIn(language, regex.exec(input)[2], regex.exec(input)[1], slave, (output) ->
    slave.sendOutputToCapability(output, "tts")
  )

module.exports = (slave) ->
  
  language = slave.getLanguage
  
  slave.setType "logic"
  slave.setName "weather"
  
  slave.registerLanguage "en", english, true
  slave.registerLanguage "de", german

  slave.registerLogic "weatherNowHere", slave.__("weatherNowHere"), weatherNowHere
  slave.registerLogic "weatherThenHere", slave.__("weatherThenHere"), weatherThenHere
  slave.registerLogic "weatherThen", slave.__("weatherThen"), weatherThen 
  slave.registerLogic "weatherNow", slave.__("weatherNow"), weatherNow


 
  
    
       
