class TagPredictionInfo < ApplicationRecord
  include Attributes::TagPredictionInfo
  include CollectionMethods::TagPredictionInfos


  # => Constants ...  
  POPULARITY_STATUS_UNPOPULAR = "unpopular"
  POPULARITY_STATUS_POPULAR = "popular"

  POPULARITY_STATUSES = [
    POPULARITY_STATUS_UNPOPULAR,
    POPULARITY_STATUS_POPULAR
  ]

  QA_PREDICT_FILE_NAME = "qa_predict_tag.txt"


  # => Relationships ...
  belongs_to :tag


  # => Validations ...
  #validates :tag, :posts_count, :questioner_experience, :net_question_upvotes, 
  #          :average_question_length, :centrality, presence: true

  validates_uniqueness_of :tag_id
  validates :popularity_status, inclusion: { :in => POPULARITY_STATUSES } 


  # => Scopes ...  
  scope :popular, -> {
    where(:popularity_status => POPULARITY_STATUS_POPULAR)
  }

  scope :unpopular, -> {
    where(:popularity_status => POPULARITY_STATUS_UNPOPULAR)
  }


  # => Callbacks ...  
  before_validation on: :create do
    # => preset the value with unpopular if nothing mentioned ...
    
    self.popularity_status = POPULARITY_STATUS_POPULAR if self.popularity_status.nil?
  end

end
