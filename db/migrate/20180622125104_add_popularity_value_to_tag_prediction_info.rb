class AddPopularityValueToTagPredictionInfo < ActiveRecord::Migration[5.0]
  def change
       add_column :tag_prediction_infos, :popularity_value, :integer, index: true, default: 0
  end
end
