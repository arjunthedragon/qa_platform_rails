class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :description, null: false
      t.integer :answered_by_id, index: true
      t.boolean :is_accepted, index: true, default: false

      t.references :post, index: true

      t.timestamps
    end
  end
end
