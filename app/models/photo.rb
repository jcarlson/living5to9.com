class Photo < ActiveRecord::Base

  validates :release_date, :timeliness => {:type => :date}

  mount_uploader :image, PhotoUploader

  attr_reader :md

  def aperture
    f = metadata.get_exif_by_entry("FNumber")[0][1]
    #(Rational(*(f.split('/').map( &:to_i )))).to_f
  end

  def caption
    metadata.get_iptc_dataset Magick::IPTC::Application::Caption
  end

  def exif
    exif = {}
    metadata.get_exif_by_entry.each {|entry| exif[entry[0]] = entry[1]}
    exif
  end

  def flash?
    (metadata.get_exif_by_entry("Flash")[0][1].to_i & 1) == 1
  end

  def image=(file)
    # let CarrierWave do its thing
    super
    # nil out any cached metadata, in case we're updating the image
    @md = nil
    # set the release date based on metadata if release date is blank
    self.release_date = metadata.get_iptc_dataset Magick::IPTC::Application::Release_Date if self.release_date.blank?
  end

  def shutter_speed
    metadata.get_exif_by_entry("ExposureTime")[0][1]
  end

  private

  def metadata
    if @md.nil?
      @md = Magick::Image.read(self.image.current_path)[0]
    end
    @md
  end

end
