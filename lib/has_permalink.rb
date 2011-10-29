module HasPermalink
  extend ActiveSupport::Concern
  
  included do
    # setup polymorphic association
    has_one :permalink, :as => :content, :dependent => :destroy, :autosave => true
    delegate :slug, :slug=, :to => :permalink
    
    # add initialization and validation callbacks
    after_initialize :build_permalink, :unless => proc { permalink.present? }
    before_validation :set_default_slug
  end
  
  module InstanceMethods
    
    protected

    # provide a suitable default slug value
    def default_slug
      nil
    end
    
    # set default_slug on permalink before validation
    def set_default_slug
      permalink.slug = default_slug unless permalink.slug.present?
    end
  
  end
  
end

module SlugRoutes
  
  # TODO: Not so sure about this... we're not returning a URL, for one
  def polymorphic_url(content, options = {})
    if content.respond_to?(:slug)
      "/#{content.slug}"
    else
      super
    end
  end
  
end

module ActionDispatch
  module Routing
    module UrlFor
      #include SlugRoutes
    end
    module Helpers
      #include SlugRoutes
    end
  end
end