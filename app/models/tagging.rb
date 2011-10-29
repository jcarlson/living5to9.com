class Tagging < ActiveRecord::Base
  # ATTRIBUTES
  
  # CALLBACKS
  
  # CONFIGURATION
  belongs_to :content, :polymorphic => true
  belongs_to :tag
  
  # SCOPES
  
  # VALIDATIONS
  validates :tag_id, :uniqueness => { :scope => :content_id }
  
end
