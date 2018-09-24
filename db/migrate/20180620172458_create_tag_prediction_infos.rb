class CreateTagPredictionInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_prediction_infos do |t|
      t.references :tag, index: true
      t.integer :posts_count
      t.integer :questioner_experience
      t.integer :net_question_votes
      t.integer :average_question_length

      t.integer :centrality

      t.timestamps
    end
  end
end
