function executeTask() as void
  urlTransfer = createUrlTransfer("https://fastpass.wdwnt.com/posts")
  json = getJson(urlTransfer)

  posts = createObject("roSGNode", "ContentNode")

  for each post in json
    post_content = posts.CreateChild("ContentNode")
    post_content.id = post.id
    post_content.title = post.title
    post_content.url = post.short_URL
    post_content.hdPosterUrl = post.featured_image
  end for

  m.top.posts = posts
end function
