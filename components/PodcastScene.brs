sub Init()
  m.top.ObserveField("wasShown", "OnWasShown")
end sub

sub OnWasShown()
  m.play_bar = m.top.findNode("play_bar")
  m.Play = m.top.findNode("Play")
  m.AlbumPlay = m.top.findNode("AlbumPlay")

  m.TimerRect = m.top.findNode("TimeBarFront")
  m.AudioCurrent = m.top.findNode("AudioCurrent")
  m.AudioDuration = m.top.findNode("AudioDuration")
  m.AudioTime = 0

  m.episode_title = m.top.findNode("episode_title")
  m.episode_description = m.top.findNode("episode_description")

  m.audiolist = m.top.findNode("audioLabelList")
  m.audiolist.observeField("itemFocused", "updateFocused")
  m.audiolist.observeField("itemSelected", "playaudio")

  m.audio = createObject("RoSGNode", "Audio")
  m.audio.observeField("state", "controlaudioplay")
  m.Audio.notificationInterval = 0.1

  m.AudioDuration.text = secondsToMinutes(0)
  m.AudioCurrent.text = secondsToMinutes(0)

  m.PlayTime = m.top.findNode("PlayTime")
  m.PlayTime.ObserveField("fire", "TimeUpdate")

  m.readAudioContentTask = createObject("RoSGNode", "PodcastTask")
  m.readAudioContentTask.observeField("content", "showaudiolist")
  m.readAudioContentTask.control = "RUN"

  m.global.observeField("FF", "FF")
  m.global.observeField("Rewind", "Rewind")
end sub

sub showaudiolist()
  m.audiolist.content = m.readAudioContentTask.content
  m.audiolist.setFocus(true)
end sub

sub TimeUpdate()
  m.AudioTime += 1
  m.AudioCurrent.text = secondsToMinutes(m.AudioTime)
  if m.AudioTime = m.check
    m.PlayTime.control = "stop"
  end if
end sub

function getSelectedEpisode() as object
  return m.audiolist.content.getChild(m.audiolist.itemFocused)
end function

sub updateFocused()
  episode = getSelectedEpisode()

  m.episode_title.text = episode.title
  m.episode_description.text = episode.Description
end sub

sub playaudio()
  episode = getSelectedEpisode()
  m.audio.content = episode

  m.audio.control = "stop"
  m.audio.control = "none"
  m.audio.control = "play"

  m.AlbumPlay.uri = episode.hdPosterUrl

  m.Play.text = "O"
  m.AudioDuration.text = secondsToMinutes(episode.Length)
  m.AudioTime = 0

  m.PlayTime.control = "start"
end sub

' function onKeyEvent(key as string, press as boolean) as boolean 'Key functions for UI
'   if press
'     if key = "replay"
'       if (m.Audio.state = "playing")
'         playaudio()
'         return true
'       end if
'     else if key = "play"
'       if (m.Audio.state = "playing")
'         m.Audio.control = "pause"
'         m.TimerAnim.control = "pause"
'         m.PlayTime.control = "stop"
'         m.Play.text = "N"
'       else
'         m.Audio.control = "resume"
'         m.TimerAnim.control = "resume"
'         m.PlayTime.control = "start"
'         m.Play.text = "O"
'       end if
'       return true
'     else if key = "right"
'       skip10Seconds(true)
'       return true
'     else if key = "left"
'       skip10Seconds(false)
'       return true
'     end if
'   end if
'   m.list.setFocus(true)
' end function

function secondsToMinutes(seconds as integer) as string
  x = seconds \ 60
  y = seconds MOD 60
  if y < 10
    y = y.toStr()
    y = "0" + y
  else
    y = y.toStr()
  end if
  result = x.toStr()
  result = result + ":" + y
  return result
end function

sub controlaudioplay()
  if (m.audio.state = "finished")
    m.audio.control = "stop"
    m.audio.control = "none"
    m.Play.text = "N"
  end if
end sub

' function onKeyEvent(key as String,press as Boolean) as Boolean
'   if press then
'     if key = "back"
'       if (m.audio.state = "playing")
'         m.audio.control = "stop"
'         m.Play.text = "N"
'         return true
'       end if
'     end if
'   end if
'   return false
' end function

' sub FF()
'     skip10Seconds(true)
' end sub

' sub Rewind()
'     skip10Seconds(false)
' end sub
