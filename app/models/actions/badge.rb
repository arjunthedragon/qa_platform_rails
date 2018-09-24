module Actions::Badge
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end


module ClassMethods

  def revise_user_badges(user)
    # => We will write the code here to revise the badge details of a user ...
    # => The monitoring is done on certain events where badges may have to be updated on these trigerrings ...
    
  end

end

module InstanceMethods

end