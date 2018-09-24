class AnswerRequest < ApplicationRecord
  include Formats::AnswerRequest

  # => Relationships ...
  belongs_to :requested_user, class_name: User.to_s
  belongs_to :post


  # => Validations ...
  validates :requested_user, presence: true
end
