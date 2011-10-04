class RenameMetadataFieldsOnPhoto < ActiveRecord::Migration
  def up
    rename_column :photos, :exif, :image_exif
    rename_column :photos, :iptc, :image_iptc
  end

  def down
    rename_column :photos, :image_exif, :exif
    rename_column :photos, :image_iptc, :iptc
  end
end
