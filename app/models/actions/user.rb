module Actions::User
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end


module ClassMethods

end

module InstanceMethods

  def reset_authentication_token
    self.authentication_token = generate_new_auth_token
    self.save
  end

  def generate_new_auth_token
    token = Devise.friendly_token
    while User.where(authentication_token: token).count > 0
      token = Devise.friendly_token
    end
    token
  end

  def suspend!
    self.is_suspended = true
    self.save!
  end

  def reinstate!
    self.is_suspended = false
    self.save!
  end

end