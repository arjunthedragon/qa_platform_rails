class ApplicationController < ActionController::Base
  
  respond_to :html, :json
  
  # this enables DSL supported by inherited resource.
  # use it to override actions after actions
  include InheritedResources::DSL
  include ActionControllerBaseCommon::Exceptions
  include ActionControllerBaseCommon::DeviseAuthentications

  before_action :authenticate_api

  after_action :set_cookies_token

  # collection override for inherited resource
  # this adds pagination automatically for all index actions
  # def collection
  #   get_collection_ivar || set_collection_ivar(end_of_association_chain.page(params[:page]).per(25))
  # end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  def set_cookies_token
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
  
  def verified_request?
    # super || form_authenticity_token == request.headers['X-XSRF-TOKEN'] Rails 4.1 & below
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def authenticate_api    
    # Api authentication ....
    # sets the user session if there is an API authentication token sent along with the request ...
    
    email = params[:email].presence
    client_resource = nil
    client_token = params[:auth_token]
    role = params[:role] || User.to_s.downcase

    if client_token.present? && role.present?
      if role.to_sym == :user
        client_resource = User.find_by_email(email)
      end
    end

    if client_resource && Devise.secure_compare(client_resource.authentication_token, client_token)
  
      result = sign_in client_resource, store: false
      
      # => Quick fix here, earlier before_filter executed before current_ability, So,
      # we did not need the below line, but since we are using before_action, we may have 
      # to call current_ability explicitly to avoid the race condition ...
      current_ability
    end
  end

  def after_sign_in_path_for(resource)
    # redirect path after loggin in ...
  
    if resource.is_a?(AdminUser)
      admin_root_url
    elsif resource.is_a?(User)
      user_url(resource)
    else
      root_url
    end
  end

  def verify_resource_suspension_status
    if [:user].include?(params[:role].to_sym)
      raise CanCan::AccessDenied
    end
  end

  def current_ability
    # => @current_ability holds the ability of the entity for signing in ...
    
    # => Fix to prevent when current_ability is called for the second time ...
    # => @current_ability should have an updated value by then ...
    return if @current_ability.present?

    if user_signed_in?
      @current_ability = Ability.new(current_user)
    else
      super
    end
  end

  def apply_has_scopes
    model_name = controller_name.classify.constantize
    resource_collection_variable_string = model_name.to_s.downcase.pluralize

    eval("
      @#{resource_collection_variable_string} ||= #{model_name}.all
      @#{resource_collection_variable_string} = apply_scopes(@#{resource_collection_variable_string}).all
    ")
  end

  def set_member_resource_variable
    model_name = controller_name.classify.constantize
    eval("@#{model_name.to_s.downcase} = #{model_name}.find(params[:id])")
  end

end
