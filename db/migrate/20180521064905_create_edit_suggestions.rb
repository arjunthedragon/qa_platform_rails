class CreateEditSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :edit_suggestions do |t|
      t.string :title
      t.text :description
      t.string :status, default: EditSuggestion::EDIT_SUGGESTION_STATUS_OPENED

      # => We did not used the polymorphic: true approach as the automatic  index name 
      #    generated was too long to fit in the database ...
      t.integer :edit_suggestionable_id
      t.string :edit_suggestionable_type

      t.timestamps
    end

    add_index :edit_suggestions, [:edit_suggestionable_type, :edit_suggestionable_id], name: :index_edit_suggestions_on_edit_suggestionable_type_and_id
  end
end
