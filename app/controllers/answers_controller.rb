class AnswersController < InheritedResources::Base
  respond_to :json

  belongs_to :post

  def accept
    @answer = Answer.where(:id => params[:id]).first

    raise ActionControllerBaseCommon::InvalidParametersException if @answer.nil?

    @answer.mark_acceptance!

    render json: {
      :message => "question mark accepted"
    }, status: 200
  end

  def unaccept
    @answer = Answer.where(:id => params[:id]).first

    raise ActionControllerBaseCommon::InvalidParametersException if @answer.nil?

    @answer.clear_acceptance!

    render json: {
      :message => "question mark unaccepted"
    }, status: 200
  end

  private

  def permitted_params
    params.permit(answer: [:id, :force_id, :description, :answered_by_id])
  end

end
