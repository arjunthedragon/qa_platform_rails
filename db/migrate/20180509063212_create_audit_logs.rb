class CreateAuditLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :audit_logs do |t|
      t.string :event
      t.string :message
      t.integer :auditor_id
      t.string :auditor_type

      t.timestamps
    end
  end
end
