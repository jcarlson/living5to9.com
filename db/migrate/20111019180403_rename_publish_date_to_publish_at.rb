class RenamePublishDateToPublishAt < ActiveRecord::Migration
  def change
    rename_column :posts, :publish_date, :publish_at
  end
end
