class Categorization < ActiveRecord::Base
  # ATTRIBUTES
  
  # CALLBACKS
  
  # CONFIGURATION
  belongs_to :content, :polymorphic => true
  belongs_to :category
  
  # SCOPES
  
  # VALIDATIONS
  validates :category_id, :uniqueness => { :scope => :content_id }
  
end
