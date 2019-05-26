sub GetContent()
    ' feed = ReadAsciiFile("pkg:/config/menu.json")
    ' json = ParseJson(feed)
    json = ParseJson("{""WDWNT"":[{""id"":0,""title"":""WDWNTunes"",""shortDescription"":""Broadcasting Magic, Music, and Mayhem"",""thumbnail"":""https://wdwnt.com/wp-content/uploads/2017/11/WDWNTunes_v3_600.png""}, {""id"":1,""title"":""Today at WDW"",""shortDescription"":""View today's and tomorrow's park hours as you would on resort TV!"",""thumbnail"":""https://wdwntnow.oseast-us-1.phoenixnap.com/images/theme-park/80007944/01.jpg""}]}")
    rootNodeArray = ParseJsonToNodeArray(json)
    m.top.content.AppendChildren(rootNodeArray)
end sub

function ParseJsonToNodeArray(jsonAA as Object) as Object
    if jsonAA = invalid then return []
    resultNodeArray = []

    for each fieldInJsonAA in jsonAA
        mediaItemsArray = jsonAA[fieldInJsonAA]
        itemsNodeArray = []
        for each mediaItem in mediaItemsArray
            itemNode = ParseMediaItemToNode(mediaItem, fieldInJsonAA)
            itemsNodeArray.Push(itemNode)
        end for
        rowNode = Utils_AAToContentNode({
            title: fieldInJsonAA
        })
        rowNode.AppendChildren(itemsNodeArray)

        resultNodeArray.Push(rowNode)
    end for

    return resultNodeArray
end function

function ParseMediaItemToNode(mediaItem as Object, mediaType as String) as Object
    itemNode = Utils_AAToContentNode({
        "id"    : mediaItem.id
        "title"    : mediaItem.title
        "hdPosterUrl" : mediaItem.thumbnail
        "Description" : mediaItem.shortDescription
    })

    if mediaItem = invalid then
        return itemNode
    end if

    return itemNode
end function
