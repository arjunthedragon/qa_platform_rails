class CommentsController < InheritedResources::Base
  respond_to :json

  private

  def permitted_params
    params.permit(comment: [:id, :description, :commented_by_id, :commentable_id, :commentable_type])
  end
end
