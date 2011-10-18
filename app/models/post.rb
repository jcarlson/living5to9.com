class Post < ActiveRecord::Base
  
  # ATTRIBUTES
  

  # CALLBACKS
  before_validation :check_publish_date

  # CONFIGURATION
  

  # SCOPES
  scope :published, lambda { where('publish_date <= ?', DateTime.now)}

  # VALIDATIONS
  validates :title, :presence => true
  validates :content, :presence => true
  validates :publish_state, :inclusion => { :in => ['draft', 'published'] }
  validates :publish_date, :timeliness => {:type => :datetime}
  
private

  def check_publish_date
    self.publish_date = DateTime.now if publish_date.blank?
  end
  
end
