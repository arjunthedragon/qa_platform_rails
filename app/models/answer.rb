class Answer < ApplicationRecord
  include Attributes::Answer
  include Formats::Answer
  include Conditions::Answer
  include Actions::Answer
  include CollectionMethods::Answers

  # => Constants ...
  ANSWER_VOTE_VALUE = 10
  ACCEPTED_ANSWER_VOTE_VALUE = 10

  
  # => Relations ...
  has_one :question, :through => :post
  has_many :answer_upvotes, -> { 
    upvoted 
  }, :dependent => :destroy, class_name: Vote.to_s, as: :voterable
  
  has_many :answer_downvotes, -> { 
    downvoted 
  }, :dependent => :destroy, class_name: Vote.to_s, as: :voterable 
  
  has_many :comments, :dependent => :destroy, :as => :commentable
  has_many :feedbacks, :dependent => :destroy, :as => :feedbackable
  has_many :edit_suggestions, :dependent => :destroy, :as => :edit_suggestionable

  belongs_to :post
  belongs_to :answered_by, class_name: User.to_s

  
  # => Validations ...
  validates :description, presence: true

  
  # => Scopes ...
  scope :accepted, -> {
    where(is_accepted: true)
  }


  # => Callbacks ...
  after_save do
    # => update the net votes count every time you make an update ...

    self.update_answer_net_votes_count!

  end
  
  before_validation on: :create do
    # => We initialize the answer acceptance status as false by default ...

    self.is_accepted = true

    if self.force_id.present?
      self.id = self.force_id
    end
  end

  
  # => Accessors ...
  attr_accessor :force_id

end
