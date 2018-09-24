class EditSuggestionsController < InheritedResources::Base
  respond_to :json


  def reopen
    @edit_suggestion = EditSuggestion.where(:id => params[:id]).first

    raise ActionControllerBaseCommon::InvalidParametersException if @edit_suggestion.nil?

    @edit_suggestion.reopen!

    render json: {
      :message => "Edit Suggestion Reopened"
    }, status: 200
  end

  def accept
    @edit_suggestion = EditSuggestion.where(:id => params[:id]).first

    raise ActionControllerBaseCommon::InvalidParametersException if @edit_suggestion.nil?

    @edit_suggestion.accept!

    render json: {
      :message => "Edit Suggestion Accepted"
    }, status: 200
  end

  def reject
    @edit_suggestion = EditSuggestion.where(:id => params[:id]).first

    raise ActionControllerBaseCommon::InvalidParametersException if @edit_suggestion.nil?

    @edit_suggestion.reject!

    render json: {
      :message => "Edit Suggestion Rejected"
    }, status: 200
  end


  private

  def permitted_params
    params.permit(edit_suggestion: [:id, :title, :description, :status, :edit_suggestionable_id, :edit_suggestionable_type, :answer_suggester_id, :question_suggester_id])
  end
  


end
