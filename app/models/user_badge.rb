class UserBadge < ApplicationRecord

  # => Relatinships ...
  belongs_to :badge
  belongs_to :user


  # => Validations ...
  validates :badge, :user, presence: true
end
