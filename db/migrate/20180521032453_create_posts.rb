class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false, index: true, unique: true
      t.string :status, null: false, index: true, default: Post::POST_STATUS_OPENED

      t.references :user, index: true
      t.references :post_category, index: true

      t.timestamps
    end
  end
end
