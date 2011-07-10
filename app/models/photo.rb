class Photo < ActiveRecord::Base

  # VALIDATIONS
  validates :release_date, :timeliness => {:type => :date, :allow_nil => true}

  # SCOPES
  named_scope :released, :conditions => ["release_date is not null"], :order => "release_date desc"

  # OTHER CONFIGURATION
  mount_uploader :image, PhotoUploader

  # return the f-stop as a float, or nil if not present
  def aperture
    f = exif["FNumber"]
    return nil if f.blank?
    (Rational(*(f.split('/').map( &:to_i )))).to_f
  end

  # indicate whether an aperture value is present
  def aperture?
    !aperture.nil?
  end

  # return the IPTC-embedded caption
  def caption
    metadata.get_iptc_dataset Magick::IPTC::Application::Caption
  end

  # return a hash of EXIF key/value pairs
  def exif
    metadata.get_exif_by_entry.reduce(Hash.new) {|hash, entry| hash[entry[0]] = entry[1]; hash }
  end

  # indicate whether the flash was fired
  def flash?
    (exif["Flash"].to_i & 1) == 1
  end

  # return the focal length as in integer, measured in millimeters, or nil if not present
  def focal_length
    l = exif["FocalLength"]
    return nil if l.blank?
    (Rational(*(l.split('/').map( &:to_i )))).to_i
  end

  # indicate whether a focal length value is present
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

  # return the shutter speed as a string, or nil if not present
  def shutter_speed
    ss = exif["ExposureTime"]
    return nil if ss.blank?
    ss
  end

  # indicate if a shutter speed value is present
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
