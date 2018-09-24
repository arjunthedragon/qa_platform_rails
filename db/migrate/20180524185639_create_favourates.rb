class CreateFavourates < ActiveRecord::Migration[5.0]
  def change
    create_table :favourates do |t|
      t.integer :favoured_by_id, index: true
      t.integer :favourate_post_id, index: true

      t.timestamps
    end
  end
end
