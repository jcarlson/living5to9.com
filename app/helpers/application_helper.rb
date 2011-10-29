module ApplicationHelper

  def frontpage?
    current_page? root_url
  end
  
  def markdown(text)
    Redcarpet.new(text).to_html.html_safe
  end

  def photopage?
    params[:controller] == 'photos'
  end

  def page_class
    params[:controller].gsub("/", "_")
  end
  
  def slug_for(content)
    if content.respond_to?(:slug)
      "/#{content.slug}"
    else
      polymorphic_path(content)
    end
  end

end
