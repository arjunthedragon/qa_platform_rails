class FavouratesController < InheritedResources::Base
  respond_to :json

  private

  def permitted_params
    params.permit(favourate: [:favoured_by_id, :favourate_post_id, :_destroy])
  end

end