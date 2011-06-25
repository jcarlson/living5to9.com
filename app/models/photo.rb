class Photo < ActiveRecord::Base

  validates :caption, :presence => true
  validates :date, :timeliness => {:type => :date}

  mount_uploader :image, PhotoUploader

  def caption
    metadata.get_iptc_dataset Magick::IPTC::Application::Caption
  end

  def image=(file)
    super
    self.release_date = metadata.get_iptc_dataset Magick::IPTC::Application::Release_Date if self.release_date.blank?
  end

  private

  def metadata
    @md = Magick::Image.read(self.image.current_path)[0] if @md.nil?
    @md
  end

end
