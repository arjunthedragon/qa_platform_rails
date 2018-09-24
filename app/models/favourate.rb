class Favourate < ApplicationRecord
  
  # => Relationships ...
  belongs_to :favoured_by, class_name: User.to_s
  belongs_to :favourate_post, class_name: Post.to_s

  # => Validations ...
  validates :favoured_by, :favourate_post, presence: true

end
