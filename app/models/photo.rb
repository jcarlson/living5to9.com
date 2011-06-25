class Photo < ActiveRecord::Base

  validates :release_date, :timeliness => {:type => :date}

  mount_uploader :image, PhotoUploader

  def aperture
    f = exif["FNumber"]
    (Rational(*(f.split('/').map( &:to_i )))).to_f
  end

  def aperture?
    !aperture.nil?
  end

  def caption
    metadata.get_iptc_dataset Magick::IPTC::Application::Caption
  end

  def exif
    metadata.get_exif_by_entry.reduce(Hash.new) {|hash, entry| hash[entry[0]] = entry[1]; hash }
  end

  def flash?
    (exif["Flash"].to_i & 1) == 1
  end

  def focal_length
    l = exif["FocalLength"]
    (Rational(*(l.split('/').map( &:to_i )))).to_i
  end

  def focal_length?
    !focal_length.nil?
  end

  def image=(file)
    # let CarrierWave do its thing
    super
    # nil out any cached metadata, in case we're updating the image
    @md = nil
    # set the release date based on metadata if release date is blank
    self.release_date = metadata.get_iptc_dataset Magick::IPTC::Application::Release_Date if release_date.blank?
  end

  def shutter_speed
    exif["ExposureTime"]
  end

  def shutter_speed?
    !shutter_speed.nil?
  end

  private

  def metadata
    if @md.nil?
      @md = Magick::Image.read(image.current_path)[0]
    end
    @md
  end

end
