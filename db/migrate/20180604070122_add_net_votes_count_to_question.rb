class AddNetVotesCountToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :net_votes_count, :integer, index: true
  end
end
