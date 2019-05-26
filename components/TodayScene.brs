sub Init()
  m.top.ObserveField("wasShown", "OnWasShown")
end sub

sub OnWasShown()
  m.top.setFocus(true)

  m.audio_track_index = 1

  m.parks = []
  m.park_id_index = 0
  m.park_ids = [ "mk", "ep", "hs", "ak", "ds", "tl", "bb" ]

  setUpTodaySceneLabels()

  buildTodaySceneTasks()

  setUpTodaySceneRefreshTimer()

  setUpTodaySceneAudio()

  refreshTodaySceneData()
end sub

sub setUpTodaySceneLabels()
  m.park_image = m.top.findNode("park_image")
  m.name = m.top.findNode("name")
  m.todaysHours = m.top.findNode("todaysHours")
  m.tomorrowsHours = m.top.findNode("tomorrowsHours")
end sub

sub buildTodaySceneTasks()
  m.TodayParkHoursTask = CreateObject("roSGNode", "TodayParkHoursTask")
  m.TodayParkHoursTask.ObserveField("parks", "onTodaySceneParksChanged")
end sub

sub setUpTodaySceneRefreshTimer()
  m.refresh_timer = m.top.findNode("refresh_timer")
  m.refresh_timer.control = "start"
  m.refresh_timer.ObserveField("fire", "changeTodayScenePark")
end sub

sub setUpTodaySceneAudio()
  m.audio = m.top.findNode("audio_player")
  m.audio.observeField("state", "todaySceneAudioPlayerStateChanged")

  changeTodaySceneAudioTrack()
end sub

sub refreshTodaySceneData()
  m.TodayParkHoursTask.control = "RUN"
end sub

sub changeTodayScenePark()
  m.park_id_index++

  if (m.park_id_index > 6) then m.park_id_index = 0

  updateTodayScenePark()
end sub

sub updateTodayScenePark()
  current_park_id = m.park_ids[m.park_id_index]
  m.current_park = m.parks[current_park_id]
  m.park_image.uri = m.current_park.imageUrl
  m.name.text = m.current_park.name
  m.todaysHours.text = m.current_park.todaysHours
  m.tomorrowsHours.text = m.current_park.tomorrowsHours
end sub

sub onTodaySceneParksChanged()
  m.parks = m.TodayParkHoursTask.parks
  updateTodayScenePark()
end sub

sub todaySceneAudioPlayerStateChanged()
  if (m.audio.state = "finished") then
    m.audio_track_index++

    if (m.audio_track_index > 16) then m.audio_track_index = 1

    changeTodaySceneAudioTrack()
  end if
end sub

sub changeTodaySceneAudioTrack()
  audiocontent = createObject("RoSGNode", "ContentNode")
  audiocontent.url = "https://wdwntnow.oseast-us-1.phoenixnap.com/music/today_at_wdw/" + m.audio_track_index.ToStr() + ".mp3"

  m.audio.content = audiocontent
  m.audio.control = "play"
end sub
