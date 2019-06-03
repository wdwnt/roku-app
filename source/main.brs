function GetSceneName() as String
    return "HomeScene"
end function

sub RunScreenSaver()
    screen = createObject("roSGScreen")
    m.port = createObject("roMessagePort")
    screen.setMessagePort(m.port)

    scene = screen.createScene("ScreensaverScene")
    screen.Show()

    while (true)
        msg = Wait(0, m.port)
        msgType = Type(msg)
        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed() then return
        end if
    end while
end sub
