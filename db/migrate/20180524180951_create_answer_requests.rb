class CreateAnswerRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_requests do |t|
      t.integer :requested_user_id, index: true

      t.references :post, index: true

      t.timestamps
    end
  end
end
