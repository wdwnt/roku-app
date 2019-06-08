sub Init()
  m.top.ObserveField("wasShown", "OnWasShown")
end sub

sub OnWasShown()
  m.play_bar = m.top.findNode("play_bar")
  m.show_art = m.top.findNode("show_art")
  m.Play = m.top.findNode("Play")

  ' m.global.observeField("FF", "FF")
  ' m.global.observeField("Rewind", "Rewind")

  m.episode_title = m.top.findNode("episode_title")
  m.episode_description = m.top.findNode("episode_description")

  m.audiolist = m.top.findNode("audioLabelList")
  m.audiolist.observeField("itemFocused", "updateFocused")
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

function getSelectedEpisode() as Object
  return m.audiolist.content.getChild(m.audiolist.itemFocused)
end function

sub updateFocused()
  episode = getSelectedEpisode()

  m.show_art.uri = episode.hdPosterUrl
  m.episode_title.text = episode.title
  m.episode_description.text = episode.Description
end sub

sub playaudio()
  episode = getSelectedEpisode()
  m.audio.content = episode

  m.audio.control = "stop"
  m.audio.control = "none"
  m.audio.control = "play"

  m.Play.text = "O"
end sub

sub controlaudioplay()
  if (m.audio.state = "finished")
    m.audio.control = "stop"
    m.audio.control = "none"
    m.Play.text = "N"
  end if
end sub

function onKeyEvent(key as String,press as Boolean) as Boolean
  if press then
    if key = "back"
      if (m.audio.state = "playing")
        m.audio.control = "stop"
        m.Play.text = "N"
        return true
      end if
    end if
  end if
  return false
end function

' sub FF()
'     skip10Seconds(true)
' end sub

' sub Rewind()
'     skip10Seconds(false)
' end sub
