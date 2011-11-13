module ApplicationHelper

  def frontpage?
    current_page? root_url
  end
  
  def markdown(text)
    opts = [:hard_wrap, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Redcarpet.new(text, *opts).to_html.html_safe
  end

  def photopage?
    params[:controller] == 'photos'
  end

  def page_class
    params[:controller].gsub("/", "_")
  end
  
end
