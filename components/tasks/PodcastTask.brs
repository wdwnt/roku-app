function executeTask() as void
  urlTransfer = createUrlTransfer("https://fastpass.wdwnt.com/podcasts?noplayer")
  json = getJson(urlTransfer)

  content = createObject("roSGNode", "ContentNode")
  htmlRegex = CreateObject("roRegex", "<.*?>", "")
  apostropheRegex = CreateObject("roRegex", "&#8217;", "")
  carriageReturnRegex = CreateObject("roRegex", "\n\n", "")

  for each podcast in json
    podcast_content = content.CreateChild("ContentNode")
    podcast_content.id = podcast.id
    podcast_content.title = podcast.title
    podcast_content.shortDescriptionLine1 = podcast.title
    podcast_content.url = podcast.media_url
    podcast_content.hdPosterUrl = podcast.featured_image

    description = htmlRegex.ReplaceAll(podcast.content, "")
    description = apostropheRegex.ReplaceAll(description, "'")
    description = carriageReturnRegex.ReplaceAll(description, chr(10))
    podcast_content.Description = description
  end for

  m.top.content = content
end function
