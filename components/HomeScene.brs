sub show(args as Object)
  m.top.backgroundColor = "0x0960CCFF"
  m.top.backgroundUri = ""

  m.grid = CreateObject("roSGNode", "GridView")
  m.grid.setFields({
    style: "hero"
    posterShape: "16x9"
  })

  content = CreateObject("roSGNode", "ContentNode")
  content.addfields({
      HandlerConfigGrid: {
          name: "GridHandler"
      }
  })

  m.grid.content = content

  m.top.ComponentController.callFunc("show", {
      view: m.grid
  })

  m.grid.ObserveField("rowItemSelected", "OnGridItemSelected")
end sub

sub OnGridItemSelected(event as Object)
  grid = event.GetRoSGNode()
  selectedIndex = event.getdata()
  view = ShowView(selectedIndex[1])
end sub

function ShowView(selectedIndex as integer)
  viewToShow = "NTunesScene"

  if selectedIndex = 1 then viewToShow = "TodayScene"

  view = CreateObject("roSGNode", viewToShow)

  m.top.ComponentController.callFunc("show", {
    view: view
  })

  return view
end function
