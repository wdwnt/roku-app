sub Init()
  m.top.ObserveField("wasShown", "OnWasShown")
end sub

sub OnWasShown()
  m.episode_poster = m.top.findNode("episode_poster")
  m.episode_description = m.top.findNode("episode_description")

  m.audiolist = m.top.findNode("audioLabelList")
  m.audiolist.observeField("itemFocused", "setaudio")
  m.audiolist.observeField("itemSelected", "playaudio")

  m.audio = createObject("RoSGNode", "Audio")
  m.audio.observeField("state", "controlaudioplay")

  m.readAudioContentTask = createObject("RoSGNode", "PodcastTask")
  m.readAudioContentTask.observeField("content", "showaudiolist")
  m.readAudioContentTask.control = "RUN"
end sub

sub showaudiolist()
  m.audiolist.content = m.readAudioContentTask.content
  m.audiolist.setFocus(true)
end sub

sub setaudio()
  episode = m.audiolist.content.getChild(m.audiolist.itemFocused)

  m.episode_poster.uri = episode.hdPosterUrl
  m.episode_description.text = episode.Description
  m.audio.content = episode
end sub

sub playaudio()
  m.audio.control = "stop"
  m.audio.control = "none"
  m.audio.control = "play"
end sub

sub controlaudioplay()
  if (m.audio.state = "finished")
    m.audio.control = "stop"
    m.audio.control = "none"
  end if
end sub

function onKeyEvent(key as String,press as Boolean) as Boolean
  if press then
    if key = "back"
      if (m.audio.state = "playing")
        m.audio.control = "stop"
        return true
      end if
    end if
  end if
  return false
end function
