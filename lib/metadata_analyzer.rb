class MetadataAnalyzer

  # Currently depends on RMagick; perhaps someday I'll look into removing that dependency and using convert/identify
  # to extract the relevant information.

  def exif(temp_object)
    image(temp_object).get_exif_by_entry.reduce(Hash.new) {|hash, entry| hash[entry[0]] = entry[1]; hash }
  end

  def iptc(temp_object)
    iptc = {}
    image(temp_object).each_iptc_dataset do |dataset, datafield|
      iptc[dataset] = datafield
    end
    iptc
  end

private

  def image(temp_object)
    ::Magick::Image.read(temp_object.path)[0]
  end

end
