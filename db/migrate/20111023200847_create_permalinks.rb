class CreatePermalinks < ActiveRecord::Migration
  def up
    create_table :permalinks do |t|
      t.string :slug
      t.integer :content_id
      t.string :content_type

      t.timestamps
    end
    
    remove_column :posts, :slug
    
  end
  
  def down
    drop_table :permalinks
    add_column :posts, :slug, :string
  end
end
