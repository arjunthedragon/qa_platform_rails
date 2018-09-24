class Department < ApplicationRecord

  # => Relationships ...
  has_many :post_categories, :dependent => :destroy
  has_many :posts, :through => :post_categories

  # => Validations ...
  validates :name, presence: true
  validates_uniqueness_of :name
end
