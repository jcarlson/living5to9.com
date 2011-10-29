class RenamePublishStateToPublished < ActiveRecord::Migration
  def change
    rename_column :posts, :publish_state, :published
  end
end
