class PostVisit < ApplicationRecord
  include Formats::PostVisit
  include Conditions::PostVisit

  # => Constants ...
  VISITOR_TYPE_GUEST = "guest"
  VISITOR_TYPE_REGISTERED_USER = "registered_user"
  VISITOR_TYPES = [
    VISITOR_TYPE_GUEST,
    VISITOR_TYPE_REGISTERED_USER
  ]


  # => Relationships ...
  belongs_to :post


  # => validations ...
  validates :post, presence: true
  validates :visitor_type, :inclusion => { :in => VISITOR_TYPES }


  # => Callbacks ...
  before_validation on: :create do
    # => Set the default vistor type as guest if nothing mentioned ...

    self.visitor_type = VISITOR_TYPE_GUEST if self.visitor_type.nil?
  end

end
