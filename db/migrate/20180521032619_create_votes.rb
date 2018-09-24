class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string :vote_type, index: true
      t.integer :voter_id, index: true

      t.references :voterable, polymorphic: true

      t.timestamps
    end
  end
end
