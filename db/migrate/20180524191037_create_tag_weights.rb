class CreateTagWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_weights do |t|
      t.integer :tag1_id, index: true
      t.integer :tag2_id, index: true
      t.integer :weight

      t.timestamps
    end
  end
end
