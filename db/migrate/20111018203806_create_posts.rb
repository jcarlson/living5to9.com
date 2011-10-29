class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.datetime :publish_date
      t.string :publish_state, :default => 'draft'
      t.string :slug

      t.timestamps
    end
  end
end
