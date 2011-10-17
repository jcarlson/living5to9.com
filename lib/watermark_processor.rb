class WatermarkProcessor

  include Dragonfly::Configurable
  include Dragonfly::ImageMagick::Utils

  configurable_attr :composite_command, "composite"
  configurable_attr :watermark_path, File.join(Rails.root, 'app', 'assets', 'images', 'watermark.png')

  def watermark(temp_object, opts={})
    tempfile = new_tempfile(opts[:format])
    run composite_command, "-gravity SouthEast #{quote(watermark_path)} #{quote(temp_object.path)} #{quote(tempfile.path)}"
    tempfile
  end
  
end