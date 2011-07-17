# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  # Override the directory where uploaded files will be stored.
  def store_dir
    "photos/#{model.id}"
  end

  version :large do

    process :resize => [640]
    process :quality => [50]

    def store_dir
      "#{super}/versions"
    end

    version :reflection do

      process :convert => :png
      process :set_content_type
      process :reflect

      # mutate original filename and ensure it ends with .png
      def full_filename(for_file)
        for_file = super(for_file)
        for_file.chomp(File.extname(for_file)) + ".png"
      end

    end

  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  private

  # Override :convert to rename the file based on the new extension
  # See https://github.com/jnicklas/carrierwave/pull/404
  def convert(format)
    manipulate!(:format => format)
    file.move_to current_path.chomp(File.extname(current_path)) + ".#{format}"
  end

  def quality(q=50)
    manipulate! {|img| img.write(current_path) {self.quality=q} }
  end

  def reflect
    manipulate! {|img| img.wet_floor 0.4, 0.7}
  end

  def resize(width)
    manipulate! { |img| img.resize_to_fit! width }
  end

end
