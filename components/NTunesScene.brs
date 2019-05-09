sub show(args as Object)
  m.top.setFocus(true)

  m.is_playing = false

  m.top.backgroundColor = "0x0960CCFF"
  m.top.backgroundUri = ""

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
end function

function buildNTunesTask() as void
  m.nTunesTask = CreateObject("roSGNode", "NTunesTask")
  m.nTunesTask.ObserveField("current_track_title", "onCurrentTrackTitleChanged")
  m.nTunesTask.ObserveField("current_track_artist_name", "onCurrentTrackArtistNameChanged")
  m.nTunesTask.ObserveField("current_show_name", "onCurrentShowNameChanged")
  m.nTunesTask.ObserveField("current_show_image_path", "onCurrentShowImagePathChanged")
end function

function setUpRefreshTimer() as void
  m.refresh_timer = m.top.findNode("refresh_timer")
  m.refresh_timer.control = "start"
  m.refresh_timer.ObserveField("fire", "refreshData")
end function

function setUpAudio() as void
  audiocontent = createObject("RoSGNode", "ContentNode")
  audiocontent.url = "https://wdwnt.out.airtime.pro/wdwnt_a"

  m.audio = m.top.findNode("audio_player")
  m.audio.content = audiocontent

  m.audiobutton = m.top.findNode("audio_control_button")
  m.audiobutton.observeField("buttonSelected", "playAudio")
end function

function refreshData() as void
  m.nTunesTask.control = "RUN"
end function

function playAudio() as void
  if (m.is_playing) then
    m.audio.control = "stop"
    m.audiobutton.text = "Play"
    m.is_playing = false
  else
    m.audio.control = "play"
    m.audiobutton.text = "Stop"
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

function onCurrentTrackTitleChanged() as void
  m.current_track_title.text = m.nTunesTask.current_track_title
end function

function onCurrentTrackArtistNameChanged() as void
  m.current_track_artist_name.text = m.nTunesTask.current_track_artist_name
end function

function onCurrentShowNameChanged() as void
  m.current_show_name.text = m.nTunesTask.current_show_name
end function

function onCurrentShowImagePathChanged() as void
  m.current_show_image_path.uri = m.nTunesTask.current_show_image_path
end function
