class TagPostsController < InheritedResources::Base

  private

  def permitted_params
    params.permit(tag_post: [:id, :tag_id, :post_id, :_destroy])
  end
end
