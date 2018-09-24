class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :description, null: false

      t.references :post, index: true

      t.timestamps
    end
  end
end
