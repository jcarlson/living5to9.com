class Tag < ActiveRecord::Base
  include HasPermalink
  
  # ATTRIBUTES
  
  # CALLBACKS
  
  # CONFIGURATION
  
  # SCOPES
  
  # VALIDATIONS
  validates :term, :uniqueness => true, :presence => true
  
protected
  
  def default_slug
    term.present? ? "tags/#{term.parameterize}" : nil
  end
  
end
