class CreateTags < ActiveRecord::Migration
  def change
    
    create_table :tags do |t|
      t.string :term
      t.string :slug

      t.timestamps
    end
    
    create_table :taggings do |t|
      t.integer :content_id
      t.string  :content_type
      t.integer :tag_id

      t.timestamps
    end
    
  end
end
