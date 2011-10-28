class Photo < ActiveRecord::Base
  include HasPermalink
  include HasTags
  
  # ATTRIBUTES
  attr_accessor :update_release_date

  # CALLBACKS
  before_validation :auto_update_release_date

  # CONFIGURATION
  accepts_nested_attributes_for :permalink
  image_accessor :image do
    after_assign { self.update_release_date = true }
  end
  serialize :image_exif, Hash
  serialize :image_iptc, Hash

  # SCOPES
  scope :released, :conditions => ["release_date is not null"], :order => "release_date desc"

  # VALIDATIONS
  validates :release_date, :timeliness => {:type => :date, :allow_nil => true}

  def self.latest
    released.first
  end

  # TODO: These convenience methods probably belong in a decorator class. Look into Draper gem.

  # return the f-stop as a float, or nil if not present
  def aperture
    f = image_exif["FNumber"]
    return nil if f.blank?
    (Rational(*(f.split('/').map( &:to_i )))).to_f
  end

  # indicate whether an aperture value is present
  def aperture?
    !aperture.nil?
  end

  # return the IPTC-embedded caption
  def caption
    image_iptc["Caption"]
  end

  # indicate whether the flash was fired
  def flash?
    (image_exif["Flash"].to_i & 1) == 1
  end

  # return the focal length as in integer, measured in millimeters, or nil if not present
  def focal_length
    l = image_exif["FocalLength"]
    return nil if l.blank?
    (Rational(*(l.split('/').map( &:to_i )))).to_i
  end

  # indicate whether a focal length value is present
  def focal_length?
    !focal_length.nil?
  end
  
  # return the IPTC headline if present
  def headline
    image_iptc["Headline"]
  end
  
  # return the IPTC release date, or default to today
  def release_date
    read_attribute(:release_date) || write_attribute(:release_date, default_release_date)
  end
  
  # return the shutter speed as a string, or nil if not present
  def shutter_speed
    ss = image_exif["ExposureTime"]
    return nil if ss.blank?
    ss
  end

  # indicate if a shutter speed value is present
  def shutter_speed?
    !shutter_speed.nil?
  end
  
protected
  
  def default_release_date
    (image_iptc["Release_Date"] || read_attribute(:release_date) || Date.today).to_date
  end
  
  def default_slug
    slug = headline.present? ? headline : File.basename(image_name, File.extname(image_name))
    "#{release_date.year}/#{release_date.month}/#{release_date.day}/#{slug.parameterize}"
  end

private

=begin

I renamed the #exif and #iptc attributes to #image_exif and #image_iptc. This makes them 'magic' attributes in
Dragonfly, and I wrote an analyser to extract this information.

I felt like pulling generic metadata from the image, as with EXIF or IPTC data, was properly suited to extracting out
into an image analyser; EXIF and IPTC are rightly properties of the image. This behavior is generic and could be reused
across other models enhanced with Dragonfly.

So why, then, didn't I make #release_date a 'magic' attribute as well? The release date is really a key/value in the
IPTC table, and the only reason we're saving it to the database is to support more efficient queries on the Photo table
by the release date property. Because this need is so specific to the Photo table, it seemed more prudent to leave this
behavior in the Photo model. However, I still wanted to auto-populate it when an explicit value is not provided. I also
wanted to incorporate a checkbox in the view to explicitly enable/disable this functionality.

The end result, then, is that #release_date will be auto-populated if #update_release_date is true, or if #release_date
is already blank and #update_release_date is not specified. This preserves the previous behavior of setting
#release_date automatically, but allows control over the action.

=end

  def auto_update_release_date
    if update_release_date
      self.release_date = default_release_date
    end
  end

end
