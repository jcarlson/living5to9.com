class AddImageToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :img, :string
  end

  def self.down
    remove_column :photos, :img
  end
end
