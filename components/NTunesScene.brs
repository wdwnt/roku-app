sub Init()
  m.top.ObserveField("wasShown", "OnWasShown")
end sub

sub OnWasShown()
  m.top.setFocus(true)

  m.durationDisplay = ""
  m.duration = 30
  m.elapsed_time = 30
  m.is_playing = false

  setUpLabels()

  buildNTunesTask()

  setUpElapsedTimeTimer()
  setUpRefreshTimer()

  setUpAudio()

  refreshData()
end sub

function setUpLabels() as void
  m.current_track_title = m.top.findNode("current_track_title")
  m.current_track_artist_name = m.top.findNode("current_track_artist_name")

  m.elapsed_time_label = m.top.findNode("elapsed_time_label")
  m.duration_label = m.top.findNode("duration_label")
  m.progress_bar = m.top.findNode("progress_bar")
  m.progress_bar_background = m.top.findNode("progress_bar_background")

  m.current_show_image_path = m.top.findNode("current_show_image_path")
  m.background = m.top.findNode("background")

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

function setUpElapsedTimeTimer() as void
  m.elapsedTime_timer = m.top.findNode("elapsedTime_timer")

  m.elapsedTime_timer.repeat = true
  m.elapsedTime_timer.duration = 1
  m.elapsedTime_timer.control = "start"

  m.elapsedTime_timer.ObserveField("fire", "updateElapsedTime")
end function

function setUpAudio() as void
  audiocontent = createObject("RoSGNode", "ContentNode")
  audiocontent.url = "http://edge1-b.exa.live365.net/a31769"
  audiocontent.streamFormat = "mp3"

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

function onKeyEvent(key as string, press as boolean) as boolean
  handled = false

  if press then
    if (key = "play") then
      playAudio()
      handled = true
    end if
  end if
end function

sub updateElapsedTime()
  m.elapsed_time--

  if m.elapsed_time < 0 then
    m.elapsed_time = 0
  end if

  elapsedTime = m.duration - m.elapsed_time
  time_minutes = Int(elapsedTime / 60)
  time_seconds = elapsedTime mod 60

  time_seconds_formatted = time_seconds.tostr()

  if time_seconds < 10 then
    time_seconds_formatted = Substitute("0{0}", time_seconds.tostr())
  end if

  m.elapsed_time_label.text = Substitute("{0}:{1}", time_minutes.tostr(), time_seconds_formatted)

  m.progress_bar.width = (1 - (m.elapsed_time / m.duration)) * 1820
end sub

sub onCurrentInfoChanged()
  toggleVisibility(true)

  current_info = m.nTunesTask.current_info["ntunes"]

  m.current_track_title.text = current_info.current_track_title
  m.current_track_artist_name.text = UCase(current_info.current_track_artist_name)

  m.current_show_image_path.uri = current_info.current_show_image_path
  m.background.uri = current_info.current_show_blurredimage_path

  refresh_duration = current_info.timeLeft

  if refresh_duration <= 0 then
    refresh_duration = 3
  end if

  m.refresh_timer.duration = refresh_duration

  m.durationDisplay = current_info.durationDisplay
  m.duration = current_info.duration
  m.elapsed_time = refresh_duration

  m.duration_label.text = current_info.durationDisplay

  m.progress_bar.width = (1 - (m.elapsed_time / m.duration)) * 1820
end sub

function toggleVisibility(visible as boolean)
  m.duration_label.visible = visible
  m.elapsed_time_label.visible = visible

  m.progress_bar.visible = visible
  m.progress_bar_background.visible = visible
end function
