class TagWeight < ApplicationRecord
  include Formats::TagWeight
  include Actions::TagWeight


  # => Relationships ...
  belongs_to :tag1, class_name: Tag.to_s
  belongs_to :tag2, class_name: Tag.to_s


  # => Validation ...
  validates :tag1, :tag2, :weight, presence: true


  # => Callbacks ...
  before_validation :assign_weight_value


  private

  def assign_weight_value
    # => We initialize the weight attribute by computing the weight between the two tags
    #    based on the logic mentioned in the IEEE paper ...

    self.weight = TagWeight.compute_weight( self.tag1, self.tag2 )
  end

end
