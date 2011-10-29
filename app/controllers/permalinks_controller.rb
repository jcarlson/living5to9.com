class PermalinksController < ApplicationController

  before_filter :find_content
  before_filter :customize_view_path

  # TODO: Need to figure out how to handle slugs with extensions, e.g., 'foo/bar/baz.jpg'
  def show

    # set params[:controller] to model of content
    params[:controller] = @content_type.pluralize.underscore
    
    # render the appropriate partial for this content, and do it in the layout
    render :partial => partial, :object => decorate(@content), :layout => true

  end

protected

  def customize_view_path
    prepend_view_path "app/views/#{@content_type.pluralize.underscore}"
  end

  def decorate(content)
    decorated = begin
      Module.const_get("#{@content_type}Decorator").decorate(content)
    rescue NameError
      content
    end
    decorated
  end
  
  def find_content
    # locate content by permalink, raising (404) error if none found
    permalink = Permalink.find_by_slug!(params[:slug])
    @content = permalink.content
    @content_type = permalink.content_type
  end
  
  def partial
    # We're going to have to make a guess about this...
    # TODO: Is there some way to still defer to the partial renderer to determine the partial to use?
    "#{@content_type.downcase.pluralize}/#{@content_type.downcase}"
  end

end
