class FeedbacksController < InheritedResources::Base
  respond_to :json

  private

  def permitted_params
    params.permit(feedback: [:id, :feedback_type, :user_id, :feedbackable_id, :feedbackable_type])
  end

end
