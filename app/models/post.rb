class Post < ActiveRecord::Base
  
  # ATTRIBUTES
  

  # CALLBACKS
  before_validation :check_publish_at

  # CONFIGURATION
  

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
  
private

  def check_publish_at
    self.publish_at = DateTime.now if publish_at.blank?
  end
  
end
