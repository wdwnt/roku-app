function executeTask() as void
  urlTransfer = createUrlTransfer("https://fastpass.wdwnt.com/podcasts")
  json = getJson(urlTransfer)

  content = createObject("roSGNode", "ContentNode")
  htmlRegex = CreateObject("roRegex", "<.*?>", "")
  apostropheRegex = CreateObject("roRegex", "&#8217;", "")

  for each podcast in json
    podcast_content = content.CreateChild("ContentNode")
    podcast_content.id = podcast.id
    podcast_content.title = podcast.title
    podcast_content.url = podcast.short_URL
    podcast_content.hdPosterUrl = podcast.featured_image

    description = htmlRegex.ReplaceAll(podcast.content, "")
    description = apostropheRegex.ReplaceAll(description, "'")
    podcast_content.Description = description
  end for

  m.top.content = content
end function
