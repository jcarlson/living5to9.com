class Post < ActiveRecord::Base
  
  # ATTRIBUTES
  

  # CALLBACKS
  before_validation :check_publish_at

  # CONFIGURATION
  has_many :taggings, :as => :content
  has_many :tags, :through => :taggings

  # SCOPES
  scope :published, lambda { where('public = ? and publish_at <= ?', true, DateTime.now)}

  # VALIDATIONS
  validates :title, :presence => true
  validates :content, :presence => true
  validates :publish_at, :timeliness => {:type => :datetime}
  
  def published
    public and publish_at < DateTime.now
  end
  alias :published? :published
  
  def publish!
    self.public = true
    self.save!
  end
  
  def status
    return "Draft" unless public
    return "Pending" unless published
    return "Published"
  end
  
  def tag_terms
    tags.map(&:term).join(", ")
  end
  
  def tag_terms=(terms)
    # split "foo, bar baz , etc; tex|mex" into ['foo', 'bar baz', 'etc', 'tex', 'mex']
    terms = terms.split(/[,;|]/).map(&:strip)
    # Find or create and then assign tag terms
    self.tags = terms.map { |term| Tag.find_or_create_by_term(term) }
  end
  
private

  def check_publish_at
    self.publish_at = DateTime.now if publish_at.blank?
  end
  
end
