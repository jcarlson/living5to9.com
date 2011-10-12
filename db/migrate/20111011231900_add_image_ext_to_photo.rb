class AddImageExtToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :image_ext, :string
  end
end
