module ActionControllerBaseCommon::Exceptions
  extend ActiveSupport::Concern

  class ActionControllerBaseCommon::InvalidParametersException < StandardError
  end
  

  included do
    include ActiveSupport::Rescuable

    rescue_from ActionControllerBaseCommon::InvalidParametersException, :with => :render_invalid_parameters
    rescue_from CanCan::AccessDenied, :with => :render_cancan_permission_denied
    rescue_from ActiveRecord::RecordNotFound, :with => :render_active_record_not_found
  end


  def render_invalid_parameters
    respond_to do |format|
      format.json {
        render json: {
          :error => "Invalid Parameters"
        }, 
        :status => 422
      }
    end

    return
  end

  def render_cancan_permission_denied
    respond_to do |format|
      format.json {
        render json: {
          :error => "Permission Denied"
        }, 
        :status => 403
      }
    end

    return
  end

  def render_active_record_not_found
    respond_to do |format|
      format.json {
        render json: {
          :error => "Invalid entity ID passed. Such an entity cannot be found in server"
        },
        :status => 404
      }
    end
  
    return
  end

end
