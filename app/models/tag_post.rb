class TagPost < ApplicationRecord

  # => Relatinships ...
  belongs_to :post
  belongs_to :tag

  # => Validations ...
  validates :tag, :post, presence: true
end
