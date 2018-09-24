class Tag < ApplicationRecord
  include Formats::Tag
  include CollectionMethods::Tags
  include Actions::Tag
  
  
  # => Relations ...
  has_many :tag_posts, :dependent => :destroy
  has_many :posts, :through => :tag_posts
  
  has_many :associated_tags, -> {
    distinct
  }, class_name: Tag.to_s, :through => :posts, :source => :tags

  has_one :tag_prediction_info


  # => Scopes ... 
  scope :popular, -> {
    includes(:tag_prediction_info)
    .where(
      :tag_prediction_infos => { 
        :popularity_status => TagPredictionInfo::POPULARITY_STATUS_POPULAR  
      }
    )
  }

  
  # => Validations ...
  validates :name, presence: true
  validates_uniqueness_of :name

  
  # => Accessors ...
  attr_accessor :force_id

  
  # => Callbacks ..,

  before_validation on: :create do

    # => You can force and ID value from API if you don't want ID to be auto generated ...
    
    if self.force_id.present?
      self.id = self.force_id
    end
  end

end
