sub Main()
    showChannelSGScreen()
end sub

sub showChannelSGScreen()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    scene = screen.CreateScene("NTunesScene")
    screen.Show()

    while true
    msg = wait(0, m.port)
    if (msg <> invalid)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end if
    end while
end sub

function GetSceneName() as String
    return "NTunesScene"
end function
