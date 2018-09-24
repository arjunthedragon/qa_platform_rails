class AddNetVotesCountToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :net_votes_count, :integer, index: true
  end
end
