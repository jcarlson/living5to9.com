class RenamePublishedToPublic < ActiveRecord::Migration
  def change
    rename_column :posts, :published, :public
  end
end
