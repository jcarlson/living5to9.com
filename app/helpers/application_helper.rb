module ApplicationHelper

  def frontpage?
    current_page? root_url
  end

  def photopage?
    params[:controller] == 'photos'
  end

  def page_class
    params[:controller].gsub("/", "_")
  end

end
