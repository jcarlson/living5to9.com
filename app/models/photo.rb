class Photo < ActiveRecord::Base

  validates :caption, :presence => true
  validates :date, :timeliness => {:type => :date}

  mount_uploader :img, PhotoUploader

end
