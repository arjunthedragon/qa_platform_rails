class Profile < ApplicationRecord
  include Formats::Profile
  include Attributes::Profile

  # => Relations ...
  has_one :user

  belongs_to :image, :class_name => Attachment, :dependent => :destroy

  delegate :attachment_url, to: :image

  
  # => Validations ...
  validates_length_of :first_name, minimum: 2

  validate :ensure_dob_valid_if_present
  

  # => Associations ...
  accepts_nested_attributes_for :image

  
  # => Scopes ...
  default_scope { 
    includes(:user) 
  }

  
  # => Callbacks ...
  before_validation :map_dob_with_dob_parameters

  
  # => Accessors ...
  attr_accessor :dob_day, :dob_month, :dob_year, :force_id


  # => Callbacks ...
  before_validation on: :create do
    if self.force_id.present?
      self.id = self.force_id
    end
  end


  private

  def ensure_dob_valid_if_present
    # => If date of birth is sent from server. We need to ensure the dob parameters are correct ...

    if [self.dob_day, self.dob_month, self.dob_year].any?
      if self.dob_day.nil?
        errors[:profile]<<" dob_day is invalid "
      elsif self.dob_day.nil?
        errors[:profile]<<" dob_month is invalid "
      elsif self.dob_month.nil?
        errors[:profile]<<" dob_year is invalid "
      end
    end
  end
        
  def map_dob_with_dob_parameters
    # => We map the date of birth parameters we obtain from json to update the dob field in this model ...
    # => PS. This is only meant for json requests ...

    # => We ignore this mapping if any of the parameters day, month or year is nil ... 

    return if (self.dob_day.nil? || self.dob_month.nil? || self.dob_year.nil? )
    
    if ( self.dob_day && self.dob_month && self.dob_year ).present?
      
      self.dob = Date.new(self.dob_year, self.dob_month, self.dob_day)
    end
  end

end
