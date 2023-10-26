function executeTask() as void
  urlTransfer = createUrlTransfer("https://wdwntunes-api.vercel.app/api/songs/now-playing")
  json = getJson(urlTransfer)

  ntunes_info = CreateObject("roAssociativeArray")
  current_info = CreateObject("roSGNode", "NTunesNode")

  current_info.current_track_title = json.title
  current_info.current_track_artist_name = json.artist
  current_info.current_show_name = ""
  current_info.current_show_image_path = json.images.url
  current_info.current_show_blurredimage_path = json.images.blurredUrl

  current_info.durationDisplay = json["playback"].durationDisplay
  current_info.duration = json["playback"].duration
  current_info.timeLeft = json["playback"].timeLeft

  ntunes_info.AddReplace("ntunes", current_info)

  m.top.current_info = ntunes_info
end function
