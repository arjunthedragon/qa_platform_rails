class Feedback < ApplicationRecord
  include Formats::Feedback

  # => Constants ...
  FEEDBACK_TYPE_HELPFUL = "helpful"
  FEEDBACK_TYPE_ABUSIVE = "abusive"
  FEEDBACK_TYPE_REOPEN = "reopen"
  FEEDBACK_TYPE_CLOSE = "close"
  FEEDBACK_TYPE_PROTECT = "protect"
  FEEDBACK_TYPE_NOT_CONSTRUCTIVE = "not_constructive"
  FEEDBACK_TYPE_DUPLICATE = "duplicate"

  FEEDBACK_TYPES = [
    FEEDBACK_TYPE_HELPFUL,
    FEEDBACK_TYPE_ABUSIVE,
    FEEDBACK_TYPE_REOPEN,
    FEEDBACK_TYPE_CLOSE,
    FEEDBACK_TYPE_PROTECT,
    FEEDBACK_TYPE_NOT_CONSTRUCTIVE,
    FEEDBACK_TYPE_DUPLICATE
  ]


  # => Relationships ...
  belongs_to :feedbackable, polymorphic: true
  belongs_to :user


  # => Validations ...
  validates :feedback_type, inclusion: { :in => FEEDBACK_TYPES }
  validates_uniqueness_of :user_id, scope: %i[feedbackable_type feedbackable_id]

  # => Scopes ...
  scope :helpful, -> {
    where(feedback_type: FEEDBACK_TYPE_HELPFUL)
  }

  scope :abusive, -> {
    where(feedback_type: FEEDBACK_TYPE_ABUSIVE)
  }

  scope :reopen, -> {
    where(feedback_type: FEEDBACK_TYPE_REOPEN)
  }

  scope :close, -> {
    where(feedback_type: FEEDBACK_TYPE_CLOSE)
  }

  scope :protect, -> {
    where(feedback_type: FEEDBACK_TYPE_PROTECT)
  }

  scope :not_constructive, -> {
    where(feedback_type: FEEDBACK_TYPE_NOT_CONSTRUCTIVE)
  }

  scope :duplicate, -> {
    where(feedback_type: FEEDBACK_TYPE_DUPLICATE)
  }

end
