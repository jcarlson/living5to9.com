class AddMetadataToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :exif, :text
    add_column :photos, :iptc, :text
  end

  def self.down
    drop_column :photos, :exif
    drop_column :photos, :iptc
  end
end
