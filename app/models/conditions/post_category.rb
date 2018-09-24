module Conditions::PostCategory
  
  def is_root_category?
    self.parent_category.nil?
  end

  def is_leaf_category?
    self.sub_post_categories.empty?
  end

end