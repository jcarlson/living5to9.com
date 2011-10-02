class Photo < ActiveRecord::Base
  serialize :exif, Hash
  serialize :iptc, Hash

  # ATTACHMENTS
  image_accessor :image do
    after_assign do |i|
      # TODO: Register this logic as a Dragonfly analyser
      img = Magick::Image.read(i.file)[0]
      self.exif = img.get_exif_by_entry.reduce(Hash.new) {|hash, entry| hash[entry[0]] = entry[1]; hash }
      iptc = {}
      img.each_iptc_dataset do |dataset, datafield|
        iptc[dataset] = datafield
      end
      self.iptc = iptc

      # set the release date based on metadata if release date is blank
      self.release_date = iptc["Release_Date"] if release_date.blank?
    end
  end

  # SCOPES
  scope :released, :conditions => ["release_date is not null"], :order => "release_date desc"

  # VALIDATIONS
  validates :release_date, :timeliness => {:type => :date, :allow_nil => true}

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
    iptc["Caption"]
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

end
