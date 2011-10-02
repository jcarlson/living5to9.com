class AddMetadataToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :exif, :text
    add_column :photos, :iptc, :text
  end

  def self.down
    remove_column :photos, :exif
    remove_column :photos, :iptc
  end
end
