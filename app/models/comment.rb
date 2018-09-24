class Comment < ApplicationRecord
  include Formats::Comment
  include Actions::Comment
  
  # => Constants ...

  
  # => Relations ...
  has_many :comment_feedbacks, as: :feedbackable, dependent: :destroy, class_name: Feedback.to_s
  
  has_many :comment_upvotes, -> {
    upvoted
  }, as: :voterable, class_name: Vote.to_s, dependent: :destroy

  has_many :comment_downvotes, -> {
  	downvoted
  }, as: :voterable, class_name: Vote.to_s, dependent: :destroy

  belongs_to :commentable, polymorphic: true
  belongs_to :commented_by, class_name: User.to_s, foreign_key: "commented_by_id"

  # => Validations ...
  validates :commentable_type, :commentable_id, :description, presence: true

end
