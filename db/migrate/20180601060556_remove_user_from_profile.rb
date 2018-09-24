class RemoveUserFromProfile < ActiveRecord::Migration[5.0]
  def change
    remove_reference :profiles, :user, index: true
  end
end
