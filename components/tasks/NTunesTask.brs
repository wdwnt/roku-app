function executeTask() as void
  urlTransfer = createUrlTransfer("https://fastpass.wdwnt.com/live365")
  json = getJson(urlTransfer)

  ntunes_info = CreateObject("roAssociativeArray")
  current_info = CreateObject("roSGNode", "NTunesNode")

  current_info.current_track_title = json["current-track"].title
  current_info.current_track_artist_name = json["current-track"].artist
  current_info.current_show_name = ""
  current_info.current_show_image_path = json["current-track"].art

  ntunes_info.AddReplace("ntunes", current_info)

  m.top.current_info = ntunes_info
end function
