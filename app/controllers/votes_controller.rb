class VotesController < InheritedResources::Base
  respond_to :json

  private

  def permitted_params
    params.permit(vote: [:id, :voter_id, :vote_type, :voterable_id, :voterable_type])
  end
  
end
