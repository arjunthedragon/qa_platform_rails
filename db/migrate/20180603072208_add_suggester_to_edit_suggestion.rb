class AddSuggesterToEditSuggestion < ActiveRecord::Migration[5.0]
  def change
    add_column :edit_suggestions, :answer_suggester_id, :integer, index: true
    add_column :edit_suggestions, :question_suggester_id, :integer, index: true
  end
end