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
    process :resize => [640]

    # Reduce quality of version for web storage
    process :quality => [50]

    version :reflection do

      process :reflect

      # filename must be mutated to ensure .png extension
      def full_filename(for_file)
        super(for_file).chomp(File.extname(super(for_file))) + '.png'
      end

    end

  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  private

  def quality(q=50)
    manipulate! {|img| img.write(current_path) {self.quality=q} }
  end

  def reflect
    manipulate!(:format => "png") do |img|
      img = img.wet_floor 0.4, 0.7
    end
  end

  def resize(width)
    manipulate! { |img| img.resize_to_fit! width }
  end

end
