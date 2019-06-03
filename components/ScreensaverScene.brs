function init()
  m.top.backgroundColor = "0x000000FF"
  m.top.backgroundUri = ""

  m.image = m.top.findNode("image")
  m.post_title = m.top.findNode("post_title")

  m.light_font = CreateObject("roSGNode", "Font")
  m.light_font.uri = "pkg:/components/fonts/avenir_45_book_latin.ttf"
  m.light_font.size = 45

  m.post_title.font = m.light_font

  m.blogTask = createObject("RoSGNode", "BlogTask")
  m.blogTask.observeField("posts", "updateBlogPosts")
  m.blogTask.control = "RUN"

  m.changepost_timer = m.top.findNode("changepost_timer")
  m.changepost_timer.control = "start"
  m.changepost_timer.ObserveField("fire", "changePost")

  m.post_count = 0
end function

sub updateBlogPosts()
  m.posts = m.blogTask.posts
end sub

sub changePost()
  if m.post_count >= m.posts.getChildCount() then m.post_count = 0

  m.post = m.posts.getChild(m.post_count)

  m.post_title.text = m.post.title
  m.image.uri = m.post.hdPosterUrl

  m.post_count++
end sub
