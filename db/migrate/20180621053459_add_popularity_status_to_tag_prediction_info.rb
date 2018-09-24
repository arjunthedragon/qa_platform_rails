class AddPopularityStatusToTagPredictionInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :tag_prediction_infos, :popularity_status, :string, index: true, default: TagPredictionInfo::POPULARITY_STATUS_UNPOPULAR
  end
end
