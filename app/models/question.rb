class Question < ApplicationRecord
  include Formats::Question
  include Actions::Question
  include Attributes::Question
  include CollectionMethods::Questions


  # => Constants ...
  QUESTION_VOTE_VALUE = 5

  
  # => Relations ...
  has_many :answers, :through => :post
  has_many :question_upvotes, -> {
    upvoted
  }, :dependent => :destroy, class_name: Vote.to_s, as: :voterable
  
  has_many :question_downvotes, -> {
    downvoted
  }, :dependent => :destroy, class_name: Vote.to_s, as: :voterable
  
  has_many :comments, :dependent => :destroy, :as => :commentable
  has_many :feedbacks, :dependent => :destroy, :as => :feedbackable
  has_many :edit_suggestions, :dependent => :destroy, :as => :edit_suggestionable

  belongs_to :post


  # => Delegations ...
  delegate :user, to: :post
  delegate :title, to: :post

  
  # => Validations ...
  validates :description, presence: true

  before_validation on: :create do
    if self.force_id.present?
      self.id = self.force_id
    end
  end

  after_save do
    self.update_question_net_votes_count!
  end


  # => Accessors ...
  attr_accessor :force_id

end
