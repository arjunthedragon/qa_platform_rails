class CreatePostVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :post_visits do |t|
      t.references :post, index: true
      t.string :visitor_type, index: true, default: PostVisit::VISITOR_TYPE_GUEST

      t.timestamps
    end
  end
end
