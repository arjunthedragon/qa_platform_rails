class AddRatioColumnsToTagPredictonInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :tag_prediction_infos, :posts_count_ratio_cents, :integer
    add_column :tag_prediction_infos, :questioner_experience_ratio_cents, :integer
    add_column :tag_prediction_infos, :net_question_votes_ratio_cents, :integer
    add_column :tag_prediction_infos, :average_question_length_ratio_cents, :integer
    add_column :tag_prediction_infos, :centrality_ratio_cents, :integer
  end
end
