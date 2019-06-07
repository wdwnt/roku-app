function executeTask() as void
  urlTransfer = createUrlTransfer("https://vip.timezonedb.com/v2/get-time-zone?key=[key]&by=position&lat=28.4160036778&lng=-81.5811902834&format=json")
  json = getJson(urlTransfer)

  datetime_info = CreateObject("roAssociativeArray")
  datetime_node = CreateObject("roSGNode", "DateTimeNode")

  datetime = CreateObject("roDateTime")
  datetime.FromISO8601String(json.formatted)

  datetime_node.day_of_the_week = datetime.GetWeekday()
  datetime_node.month_day = getMonthDay(datetime)
  datetime_node.time = getCurrentTime(datetime)

  datetime_info.AddReplace("datetime", datetime_node)

  m.top.datetime_info = datetime_info
end function

function getMonthDay(datetime) as string
  months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ]
  month = months[datetime.GetMonth() - 1]

  dayOfMonth = datetime.GetDayOfMonth().ToStr()

  return Substitute("{0} {1}", month, dayOfMonth)
end function

function getCurrentTime(datetime) as string
  hours = datetime.GetHours()

  ampm = "AM"
  if (hours >= 12) then ampm = "PM"

  current_hour = hours
  if hours > 12 then current_hour = hours - 12
  if hours = 0 then current_hour = 12

  minutes = datetime.GetMinutes()
  minutes_formatted = minutes.ToStr()
  if (minutes < 10) then minutes_formatted = "0" + minutes.ToStr()

  return Substitute("{0}:{1} {2}", current_hour.ToStr(), minutes_formatted, ampm)
end function