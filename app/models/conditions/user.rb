module Conditions::User

  def is_suspended?
    self.is_suspended == true
  end

end