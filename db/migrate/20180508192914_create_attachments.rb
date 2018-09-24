class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.references :attachable, polymorphic: true
      t.attachment :file

      t.timestamps
    end
  end
end
