class Post < ActiveRecord::Base
  
  # ATTRIBUTES
  

  # CALLBACKS
  

  # CONFIGURATION
  

  # SCOPES
  scope :published, lambda { where('publish_date <= ? or publish_date IS NULL', DateTime.now)}

  # VALIDATIONS
  validates :title, :presence => true
  validates :content, :presence => true
  validates :publish_state, :inclusion => { :in => ['draft', 'published'] }
  validates :publish_date, :timeliness => {:type => :datetime, :allow_nil => true}
  
end
