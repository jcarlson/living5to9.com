class Post < ActiveRecord::Base
  include HasPermalink
  
  # ATTRIBUTES

  # CALLBACKS

  # CONFIGURATION
  has_many :taggings, :as => :content, :dependent => :destroy
  has_many :tags, :through => :taggings
  
  accepts_nested_attributes_for :permalink
  
  # SCOPES
  scope :published, lambda { where('public = ? and publish_at <= ?', true, DateTime.now)}

  # VALIDATIONS
  validates :title, :presence => true
  validates :content, :presence => true
  validates :publish_at, :timeliness => {:type => :datetime}
  
  def publish_at
    read_attribute(:publish_at) || write_attribute(:publish_at, DateTime.now)
  end
  
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
  
protected
  
  def default_slug
    title.present? ? "#{publish_at.year}/#{publish_at.month}/#{title.parameterize}" : nil
  end
  
end
