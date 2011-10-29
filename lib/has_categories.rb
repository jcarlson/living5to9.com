module HasCategories
  extend ActiveSupport::Concern
  
  included do
    has_many :categorizations, :as => :content, :dependent => :destroy
    has_many :categories, :through => :categorizations, :order => :name
  end
  
  module InstanceMethods
    
    def category_names
      categories.map(&:name).join(", ")
    end
    
  end
  
end