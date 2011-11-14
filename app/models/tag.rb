class Tag < ActiveRecord::Base
  include Slug
  
  # ATTRIBUTES
  
  # CALLBACKS
  
  # CONFIGURATION
  
  # SCOPES
  
  # VALIDATIONS
  validates :term, :uniqueness => true, :presence => true
  
  # Convert
  def self.to_tags(terms)
    # split "foo, bar baz , etc; tex|mex" into ['foo', 'bar baz', 'etc', 'tex', 'mex']
    terms = terms.nil? ? [] : terms.split(/[,;|]/).map(&:strip)
    # Find or create and then assign tag terms
    terms.map { |term| Tag.find_or_create_by_term(term) }
  end
  
protected
  
  def default_slug
    term.present? ? "tags/#{term.parameterize}" : nil
  end
  
end
