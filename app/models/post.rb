class Post < ActiveRecord::Base
  
  # ATTRIBUTES
  

  # CALLBACKS
  before_validation :check_publish_at

  # CONFIGURATION
  

  # SCOPES
  scope :published, lambda { where('published = ? and publish_at <= ?', true, DateTime.now)}

  # VALIDATIONS
  validates :title, :presence => true
  validates :content, :presence => true
  validates :publish_at, :timeliness => {:type => :datetime}
  
  def publish!
    self.published = true
    self.save!
  end
  
private

  def check_publish_at
    self.publish_at = DateTime.now if publish_at.blank?
  end
  
end
