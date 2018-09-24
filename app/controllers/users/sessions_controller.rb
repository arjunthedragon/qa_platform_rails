# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  respond_to :html, :json

  #before_action :verify_user_login_parameters, only: [:create]
  
  #def create
  #  respond_to do |format|
  #    format.html { super }
  #    format.json {
  #      resource = User.find_for_authentication(email: params[:user][:email])
  #      if resource.present? && resource.valid_password?(params[:user][:password])
  #        if resource.respond_to?('confirmed?')
  #          unless resource.confirmed?
  #            render status: 208, json: {success: false, error: 'Not confirmed yet'} and return
  #          end
  #        end
  #
  #        render json: { user: get_user_json(resource), success: true }
  #     else
  #        render status: 401, json: {success: false, errors: 'Invalid username or password'}
  #      end
  #    }
  #  end
  #end

  def respond_with(resource, opts = {})
    respond_to do |format|
      format.html { super }
      format.json { render json: resource.session_details }
    end
  end


  private

  def verify_user_login_parameters
    ( email, password = params[:user][:email], params[:user][:password] ) rescue raise ActionControllerBaseCommon::InvalidParametersException
  end
end
