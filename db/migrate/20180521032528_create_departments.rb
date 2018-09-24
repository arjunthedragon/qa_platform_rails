class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :departments do |t|
      t.string :name, null: false, unique: true
      t.text :description

      t.timestamps
    end
  end
end
