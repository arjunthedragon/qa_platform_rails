class AddExperienceToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :experience_value, :integer, index: true
  end
end
