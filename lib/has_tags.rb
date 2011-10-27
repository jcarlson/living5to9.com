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
      # split "foo, bar baz , etc; tex|mex" into ['foo', 'bar baz', 'etc', 'tex', 'mex']
      terms = terms.split(/[,;|]/).map(&:strip)
      # Find or create and then assign tag terms
      self.tags = terms.map { |term| Tag.find_or_create_by_term(term) }
    end
    
  end
  
end