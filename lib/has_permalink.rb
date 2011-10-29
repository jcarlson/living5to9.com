module HasPermalink
  extend ActiveSupport::Concern
  
  included do
    # setup polymorphic association
    has_one :permalink, :as => :content, :dependent => :destroy, :autosave => true
    delegate :slug, :slug=, :to => :permalink
    
    # add initialization and validation callbacks
    # TODO: Optimize this so it's not called unless necessary
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
