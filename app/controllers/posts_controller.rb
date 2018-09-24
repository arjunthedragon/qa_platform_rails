class PostsController < InheritedResources::Base
  #load_and_authorize_resource
  respond_to :json

  belongs_to :user, optional: true

  def favoured_users

    @post = Post.where(:id => params[:id]).first

    raise ActionControllerBaseCommon::InvalidParametersException if @post.nil?

    render json: {
      :favoured_users => @post.favoured_users.as_json
    }
  end

  def remove_tags
    tag_ids = params[:tag_ids]
    @post = Post.where(:id => params[:id]).first

    raise ActionControllerBaseCommon::InvalidParametersException if @post.nil?
    raise ActionControllerBaseCommon::InvalidParametersException if !@post.are_tag_ids_valid?(tag_ids)

    @post.remove_tags!(tag_ids)

    render :json => {
        :post_tags => @post.tags.as_json
    }, status: 200

  end

  private

  def permitted_params
    params.permit(post: [:id, :force_id, :title, :status, :post_category_id, :user_id, tag_ids: [],
      question_attributes: [:id, :description, :force_id], answer_requests_attributes: [:id, :requested_user_id, :_destroy]])
  end

#  def post_params
#    params.require(:post).permit(:id, :title, :status, :post_category_id, :user_id,
#      question_attributes: [:id, :description], answer_requests_attributes: [:id, :requested_user_id, :_destroy])
#  end

end