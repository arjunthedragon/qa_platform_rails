module Conditions::PostVisit

  def is_visitor_type_quest?
    self.visitor_type == PostVisit::VISITOR_TYPE_GUEST
  end

  def is_visitor_type_registered_user?
    self.visitor_type == PostVisit::VISITOR_TYPE_REGISTERED_USER
  end
end