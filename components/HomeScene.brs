sub show(args as Object)
  updateTheme("0x0960CCFF")

  m.grid = m.top.findNode("grid")
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

  if selectedIndex = 0 or selectedIndex = 1 then
    updateTheme("0x121212FF")
  end if

  if selectedIndex = 1 then viewToShow = "PodcastScene"
  if selectedIndex = 2 then viewToShow = "TodayScene"

  if selectedIndex = 3 then
    viewToShow = "HorizonsScene"
    updateTheme("0x000000FF")
  end if

  view = CreateObject("roSGNode", viewToShow)
  view.ObserveField("wasClosed", "onViewWasClosed")

  m.top.ComponentController.callFunc("show", {
    view: view
  })

  return view
end function

sub onViewWasClosed(event as Object)
  updateTheme("0x0960CCFF")
end sub

function updateTheme(backgroundColor) as void
  m.top.backgroundColor = backgroundColor
  m.top.backgroundUri = ""
  m.top.theme = {
      global: {
        OverhangVisible: false
      }
      gridView: {
        backgroundColor: backgroundColor
        descriptionmaxWidth: 1000
        rowLabelColor: backgroundColor
      }
  }
end function
