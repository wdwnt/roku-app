sub GetContent()
    feed = ReadAsciiFile("pkg:/components/config/menu.json")
    json = ParseJson(feed)
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
