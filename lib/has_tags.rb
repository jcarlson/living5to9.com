module HasTags
  extend ActiveSupport::Concern
  
  included do
    has_many :taggings, :as => :content, :dependent => :destroy
    has_many :tags, :through => :taggings
  end
  
  module InstanceMethods
    
    def tag_terms
      tags.map(&:term).join(", ")
    end

    def tag_terms=(terms)
      self.tags = Tag.to_tags(terms)
    end
    
  end
  
end