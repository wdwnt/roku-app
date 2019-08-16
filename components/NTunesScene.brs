sub Init()
  m.top.ObserveField("wasShown", "OnWasShown")
end sub

sub OnWasShown()
  m.is_playing = false

  setUpLabels()

  buildNTunesTask()

  setUpRefreshTimer()

  setUpAudio()

  refreshData()
end sub

function setUpLabels() as void
  m.current_track_title = m.top.findNode("current_track_title")
  m.current_track_artist_name = m.top.findNode("current_track_artist_name")
  m.current_show_name = m.top.findNode("current_show_name")
  m.current_show_image_path = m.top.findNode("current_show_image_path")

  m.audio_indicator = m.top.findNode("audio_indicator")
end function

function buildNTunesTask() as void
  m.nTunesTask = CreateObject("roSGNode", "NTunesTask")
  m.nTunesTask.ObserveField("current_info", "onCurrentInfoChanged")
end function

function setUpRefreshTimer() as void
  m.refresh_timer = m.top.findNode("refresh_timer")
  m.refresh_timer.control = "start"
  m.refresh_timer.ObserveField("fire", "refreshData")
end function

function setUpAudio() as void
  audiocontent = createObject("RoSGNode", "ContentNode")
  audiocontent.url = "https://streaming.live365.com/a31769"

  m.audio = m.top.findNode("audio_player")
  m.audio.content = audiocontent
end function

function refreshData() as void
  m.nTunesTask.control = "RUN"
end function

function playAudio() as void
  if (m.is_playing) then
    m.audio.control = "stop"
    m.audio_indicator.text = "N"
    m.is_playing = false
  else
    m.audio.control = "play"
    m.audio_indicator.text = "O"
    m.is_playing = true
  end if
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false

  if press then
    if (key = "play") then
      playAudio()
      handled = true
    endif
  endif
end function

sub onCurrentInfoChanged()
  current_info = m.nTunesTask.current_info["ntunes"]
  m.current_track_title.text = current_info.current_track_title
  m.current_track_artist_name.text = current_info.current_track_artist_name
  m.current_show_name.text = current_info.current_show_name
  m.current_show_image_path.uri = current_info.current_show_image_path
end sub
