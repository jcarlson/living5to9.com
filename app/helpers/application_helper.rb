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
  
end
