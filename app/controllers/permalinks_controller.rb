class PermalinksController < ApplicationController
  
  # TODO: How do we ensure that the content's aasset types (CSS and JS) are included?
  # in the layout, only permalinks.js and permalink.css are included under the current setup
  
  def show
    permalink = Permalink.find_by_slug!(params[:slug])
    render permalink.content, :layout => true
  end

end
