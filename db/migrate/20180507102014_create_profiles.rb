class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name, default: '', index: true
      t.string :last_name, default: '', index: true
      t.date :dob
      t.integer :image_id


      t.references :user

      t.timestamps
    end
  end
end
