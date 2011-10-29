class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    create_table :categorizations do |t|
      t.integer :content_id
      t.string :content_type
      t.integer :category_id

      t.timestamps
    end
  end
end
