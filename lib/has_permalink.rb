module HasPermalink
  extend ActiveSupport::Concern
  
  included do
    # setup polymorphic association
    has_one :permalink, :as => :content, :dependent => :destroy
    delegate :slug, :slug=, :to => :permalink
    
    # add validation callbacks
    before_validation :set_default_slug

    # This little syntactic sugar causes permalink to be created lazily precisely
    # the first time it is accessed. This is necessary because we delegate :slug
    # to :permalink, and if permalink is nil, things get hairy.
    redefine_method(:permalink) do |*args|
      association(:permalink).reader(*args) || build_permalink(*args)
    end

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
