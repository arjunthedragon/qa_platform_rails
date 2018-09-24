class CreatePostCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :post_categories do |t|
      t.string :name, index: true
      t.text :description
      t.integer :parent_category_id, index: true

      t.references :department, index: true

      t.timestamps
    end
  end
end
