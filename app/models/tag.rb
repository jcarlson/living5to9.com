class Tag < ActiveRecord::Base
  # ATTRIBUTES
  
  # CALLBACKS
  before_validation :auto_slug
  
  # CONFIGURATION
  
  # SCOPES
  
  # VALIDATIONS
  validates :term, :uniqueness => true, :presence => true
  validates :slug, :uniqueness => true, :presence => true
  
  protected
  
  def auto_slug
    self.slug = self.term.parameterize unless term.nil? or slug.present?
  end
  
end
