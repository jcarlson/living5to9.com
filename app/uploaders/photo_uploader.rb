# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  # Override the directory where uploaded files will be stored.
  def store_dir
    "uploads/photos/#{model.id}"
  end

  # Large format version, suitable for the standard photo viewer page
  version :large do

    def store_dir
      "uploads/photos/#{model.id}/versions"
    end

    # Resize down to viewer's width and max height
    process :resize_to_fit => [640, 1280]

    # Reduce quality of version for web storage
    process :quality => [50]

    version :reflected do

      # process :reflection

      # def filename
      #   super.chomp(File.extname(super)) + '.png'
      # end

    end

  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  private

  def quality(q=50)
    manipulate! {|img| img.write(current_path) {self.quality=q}}
  end

  def reflection
    manipulate!(:format => "png") do |img|
      img = img.wet_floor 0.4, 0.7
      img.write(current_path) {self.quality=50}
    end
  end

end
