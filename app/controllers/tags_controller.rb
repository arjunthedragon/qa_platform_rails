class TagsController < InheritedResources::Base
  respond_to :json

  has_scope :popular

  def is_popular

  	posts_count = params[:posts_count]
  	questioner_experience = params[:questioner_experience]
  	net_votes_count = params[:net_votes_count]
  	average_question_length = params[:average_question_length]
  	centrality = params[:centrality]

  end

  private

  def permitted_params
    params.permit(tag: [:id, :force_id, :name, :description, :_destroy])
  end



end
