class Photo < ActiveRecord::Base

  validates :caption, :presence => true
  validates :date, :timeliness => {:type => :date}

end
