sub init()
  m.top.functionName = "executeTask"
end sub

function executeTask() as void
  url = CreateObject("roUrlTransfer")
  url.SetCertificatesFile("common:/certs/ca-bundle.crt")
  url.InitClientCertificates()
  url.setUrl("https://fastpass.wdwnt.com/radio")

  json = ParseJson(url.GetToString())

  ntunes_info = CreateObject("roAssociativeArray")
  current_info = CreateObject("roSGNode", "NTunesNode")

  current_info.current_track_title = json.current.metadata.track_title
  current_info.current_track_artist_name = json.current.metadata.artist_name
  current_info.current_show_name = json.currentShow[0].name
  current_info.current_show_image_path = json.currentShow[0].image_path

  ntunes_info.AddReplace("ntunes", current_info)

  m.top.current_info = ntunes_info
end function
