class PermalinksController < ApplicationController
  
  # TODO: Need to figure out how to handle slugs with extensions, e.g., 'foo/bar/baz.jpg'
  def show
    # locate content by permalink, raising error if none found
    permalink = Permalink.find_by_slug!(params[:slug])
    
    # set params[:controller] to model of content
    params[:controller] = permalink.content_type.pluralize.underscore
    
    # render the appropriate partial for this content, and do it in the layout
    render permalink.content, :layout => true
  end

end
