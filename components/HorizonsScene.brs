sub Init()
  m.top.ObserveField("wasShown", "OnWasShown")
end sub

sub OnWasShown()
  m.is_playing = false
  m.blink_status = false

  m.textblink_timer = m.top.findNode("textblink_timer")
  m.textblink_timer.control = "start"
  m.textblink_timer.ObserveField("fire", "blinkText")

  m.left_side_row_2_flight = m.top.findNode("left_side_row_2_flight")
  m.left_side_row_2_destination = m.top.findNode("left_side_row_2_destination")
  m.left_side_row_2_service = m.top.findNode("left_side_row_2_service")
  m.left_side_row_2_gate = m.top.findNode("left_side_row_2_gate")
  m.left_side_row_2_status = m.top.findNode("left_side_row_2_status")

  audiocontent = createObject("RoSGNode", "ContentNode")
  audiocontent.url = "https://appcdn.wdwnt.com/roku/music/Epcot%20-%20Horizons%20(Full%20Audio).mp3"

  m.audio = m.top.findNode("audio")
  m.audio.content = audiocontent
  m.audio.control = "play"
end sub

sub blinkText()
  color = "0xFFCC00FF"

  if m.blink_status then
    color = "0xFFCC00FF"
  else
    color = "0x000000FF"
  end if

  m.blink_status = not m.blink_status

  m.left_side_row_2_flight.color = color
  m.left_side_row_2_destination.color = color
  m.left_side_row_2_service.color = color
  m.left_side_row_2_gate.color = color
  m.left_side_row_2_status.color = color
end sub
