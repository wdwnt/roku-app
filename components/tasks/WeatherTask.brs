function executeTask() as void
  urlTransfer = createUrlTransfer("https://fastpass.wdwnt.com/weather/wdw")
  json = getJson(urlTransfer)

  weather_info = CreateObject("roAssociativeArray")
  weather_node = CreateObject("roSGNode", "WeatherNode")

  weather_node.currently_summary = json.currently.summary
  weather_node.currently_icon = json.currently.icon
  weather_node.currently_temperature_f = Int(json.currently.temperature)
  weather_node.currently_temperature_c = Int((5 / 9) * (json.currently.temperature - 32))

  weather_info.AddReplace("weather", weather_node)

  m.top.weather_info = weather_info
end function
