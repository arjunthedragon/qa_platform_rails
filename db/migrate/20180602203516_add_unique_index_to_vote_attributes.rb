class AddUniqueIndexToVoteAttributes < ActiveRecord::Migration[5.0]
  def change
    add_index :votes, [:voter_id, :vote_type, :voterable_type, :voterable_id], name: "voter_main_attributes_unique_index", unique: true
  end
end
