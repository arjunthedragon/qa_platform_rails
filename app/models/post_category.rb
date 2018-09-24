class PostCategory < ApplicationRecord
  include Formats::PostCategory
  include Attributes::PostCategory
  include Conditions::PostCategory

  
  # => Constants ...
  POST_CATEGORY_ROOT = "root"  

  
  # => Relations ...
  has_many :posts, :dependent => :destroy
  has_many :sub_post_categories, :dependent => :destroy, class_name: PostCategory.to_s, :foreign_key => 'parent_category_id'
  
  belongs_to :department
  belongs_to :parent_post_category, class_name: PostCategory.to_s, foreign_key: "parent_category_id"
  

  # => Validations ...
  validates :name, :department, presence: true
  validates_uniqueness_of :name
  validate :ensure_product_categories_cannot_be_cyclic

  private 

  def ensure_product_categories_cannot_be_cyclic
    # => This indicates for the scenario where you parent or grandparent(s) becomes your child 
    # => somewhere down the league ...

    if self.sub_post_categories.map(&:id).include?(self.parent_post_category)
      errors[:post_categories]<< " cannot be cyclic"
    end
  end
  
end
