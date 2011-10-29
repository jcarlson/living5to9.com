class Post < ActiveRecord::Base
  include HasCategories
  include HasPermalink
  include HasTags
  
  # ATTRIBUTES

  # CALLBACKS

  # CONFIGURATION
  
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
  
protected
  
  # Override scoped finder to further restrict returned Posts
  def self.scoped_by_permalink(permalink)
    # we're ignoring the super scope so we can start with the :published scope above
    published.where(:id => permalink.content_id)
  end
  
  def default_slug
    title.present? ? "#{publish_at.year}/#{publish_at.month}/#{title.parameterize}" : nil
  end
  
end
