class UsersController < InheritedResources::Base
  #load_and_authorize_resource
  respond_to :json

  def answered_posts

    @user = User.where(:id => params[:id]).first

    raise ActionControllerBaseCommon::InvalidParametersException if @user.nil?

    render json: {
      :answered_posts => @user.answered_posts.as_json
    }
  end

  def favourate_posts

    @user = User.where(:id => params[:id]).first

    raise ActionControllerBaseCommon::InvalidParametersException if @user.nil?

    render json: {
      :favourate_posts => @user.favourate_posts.as_json
    }
  end    

  private

  def permitted_params
    params.permit(user: [:id, :force_id, :email, :password, :password_confirmation, :current_password, :phone_number,
      profile_attributes: [:id, :force_id, :first_name, :last_name, :dob, :dob_day, :dob_month, :dob_year, image_attributes: [:id, :file]]])
  end

end
