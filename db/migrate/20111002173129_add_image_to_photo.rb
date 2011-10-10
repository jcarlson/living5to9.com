class AddImageToPhoto < ActiveRecord::Migration
  def up

    # add column to save Dragonfly UID
    add_column :photos, :image_uid, :string
    # and drop the image column previously used for CarrierWave
    remove_column :photos, :image

    # TODO: https://github.com/markevans/dragonfly/issues/130
    # if that issue is resolved, we can move the IPTC and EXIF
    # data out of the database and into the Dragonfly metadata storage
    #remove_column :photos, :exif
    #remove_column :photos, :iptc
    
  end

  def down
    remove_column :photos, :image_uid
    add_column :photos, :image, :string
  end
end
