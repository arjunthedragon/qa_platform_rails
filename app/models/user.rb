class User < ApplicationRecord
  include Attributes::User
  include Formats::User
  include Conditions::User
  include Actions::User
  include CollectionMethods::Users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # => Constants ...
  ####### Audit Log #######
  AE_PW_CHANGE = 'password change'
  AUDIT_EVENTS = [AE_PW_CHANGE]
  #########################

  
  # => Relations ...
  has_many :audit_logs, :as => :auditor
  has_many :answer_requests, :dependent => :destroy, foreign_key: "requested_user_id"
  has_many :answer_requested_posts, :through => :answer_requests, :source => :post
  has_many :user_badges, :dependent => :destroy
  has_many :badges, :through => :user_badges, :dependent => :destroy
  has_many :favourates, :dependent => :destroy, foreign_key: "favoured_by_id"
  has_many :favourate_posts, :through => :favourates, :source => :favourate_post
  has_many :posts, dependent: :destroy
  has_many :question_upvotes, :through => :posts
  has_many :question_downvotes, :through => :posts
  has_many :answers, :dependent => :destroy, foreign_key: "answered_by_id"
  has_many :answered_posts, class_name: Post.to_s, :through => :answers ,:source => :post
  has_many :answer_upvotes, :through => :answers
  has_many :answer_downvotes, :through => :answers
  has_many :accepted_answers, -> {
    accepted
  }, :class_name => Answer.to_s, foreign_key: "answered_by_id"

  has_many :answer_edit_suggestions, as: :edit_suggestionable, foreign_key: "answer_suggester_id"
  has_many :question_edit_suggestion, as: :edit_suggestionable, foreign_key: "question_suggester_id"
  has_many :comments, :dependent => :destroy, foreign_key: "commented_by_id"
  has_many :answer_feedbacks, :dependent => :destroy, :through => :answers, source: :feedbacks
  has_many :question_feedbacks, :dependent => :destroy, :through => :posts, source: :question_feedbacks

  belongs_to :profile, :dependent => :destroy

  
  # => Validations ...
  validates :profile, presence: true
  validates :phone_number, presence: true, format: { with: ActiveRecordBaseCommon::Validations::VALID_PHONE_FORMAT }
  validates_inclusion_of :experience_value, :in => 1..10
  validates_uniqueness_of :phone_number

  # => Associations ...
  accepts_nested_attributes_for :profile
  
  
  # => Callbacks ...  
  before_validation on: :create do

    # => experience value is set to 1 by default if you don't provide any ...
    # => force_id is send via API if you don't want ID generation by default ...

    if self.experience_value.nil?
      self.experience_value = 1
    end

    if self.force_id.present?
      self.id = self.force_id 
    end    
  
  end

  before_save do
    # => Randomly assign an authentication token every time you save the entry ....

    if self.authentication_token.blank?
      self.authentication_token = generate_new_auth_token
    end

  end


  # => Accessors ...
  attr_accessor :force_id

  
end
