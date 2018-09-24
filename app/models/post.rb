class Post < ApplicationRecord
  include ActiveRecordBaseCommon::Validations
  include Attributes::Post
  include Formats::Post
  include Conditions::Post
  include Actions::Post
  include CollectionMethods::Posts


  # => Constants ...
  POST_STATUS_OPENED = "opened"
  POST_STATUS_CLOSED = "closed"
  POST_STATUS_PROTECTED = "protected"
  POST_STATUS_NOT_CONSTRUCTIVE = "not_constructive"
  POST_STATUS_DUPLICATE = "duplicate"
  
  POST_STATUSES = [
    POST_STATUS_OPENED,
    POST_STATUS_CLOSED,
    POST_STATUS_PROTECTED,
    POST_STATUS_NOT_CONSTRUCTIVE,
    POST_STATUS_DUPLICATE
  ]

  
  # => Relations ...
  has_many :answers, :dependent => :destroy
  has_many :answer_requests, :dependent => :destroy
  has_many :requested_users, :through => :answer_requests, :class_name => User.to_s
  has_many :tag_posts, :dependent => :destroy
  has_many :tags, :through => :tag_posts
  has_many :favourates, :dependent => :destroy, :foreign_key => "favourate_post_id"
  has_many :favoured_users, class_name: User.to_s, :through => :favourates, :source => :favoured_by

  has_one :question, :dependent => :destroy
  has_many :question_upvotes, :through => :question
  has_many :question_downvotes, :through => :question
  has_many :question_feedbacks, :through => :question, :source => :feedbacks
  has_many :post_visits, :dependent => :destroy

  has_one :accepted_answer,-> { accepted }, class_name: Answer.to_s 

  belongs_to :post_category
  belongs_to :user


  # => Delegations ...
  delegate  :description, to: :question
  delegate :comments, to: :question
  delegate :feedbacks, to: :question
  delegate :net_votes_count, to: :question, prefix: true
  delegate :experience_value, to: :user, prefix: true  
  
  # => Validations ...
  validates :title, presence: true
  validates :status, inclusion: { :in => POST_STATUSES }
  validates :question, has_one: true

  validates_uniqueness_of :title


  # => Associations ...
  accepts_nested_attributes_for :question
  accepts_nested_attributes_for :answer_requests, :allow_destroy => true


  # => Scopes ...
  scope :opened, -> {
    where(status: POST_STATUS_OPENED)
  }
  
  scope :closed, -> {
    where(status: POST_STATUS_CLOSED)
  }

  scope :protected_posts, -> {
    where(status: POST_STATUS_PROTECTED)
  }

  scope :not_constructive, -> {
    where(status: POST_STATUS_NOT_CONSTRUCTIVE)
  }

  scope :duplicate, -> {
    where(status: POST_STATUS_DUPLICATE)
  }

  
  # => Accessors....
  attr_accessor :force_id


  # => Callbacks ...  
  before_validation on: :create do
    # => We initialize the post status as open ...

    self.status = POST_STATUS_OPENED
    
    if self.force_id.present?
      self.id = self.force_id
    end
  end
end
