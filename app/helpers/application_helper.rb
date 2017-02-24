module ApplicationHelper

  def tag_list(script)
    content_tag(:p,
                script.tags.map{ |tag|
                  tag = tag.name
                  content_tag(:a, tag, href: scripts_path(:tag => tag))
                }.join(',').html_safe)
  end

  def markdown(script)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      filter_html: true,
      no_images: true)
    markdown.render(script.notes).html_safe
  end
  
end
