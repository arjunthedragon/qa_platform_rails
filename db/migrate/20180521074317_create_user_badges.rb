class CreateUserBadges < ActiveRecord::Migration[5.0]
  def change
    create_table :user_badges do |t|
      t.references :user, index: true
      t.references :badge, index: true

      t.timestamps
    end
  end
end
