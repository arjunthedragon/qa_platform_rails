module Attributes::PostCategory

  def leaf_categories

    return [self] if self.is_leaf_category?

    self.sub_post_categories.map(&:leaf_categories).flatten
  end


  def sub_n_level_categories
    return [] if self.is_leaf_category?

    categories = self.sub_post_categories 
    categories += self.sub_post_categories.map(&:sub_n_level_categories)
    categories.flatten
  end


  def root_category
    return self if self.is_root_category?

    self.parent_post_category.root_category
  end


  def sub_n_level_categories_products(posts_scoped = nil, options = {})
    posts_scoped ||= Post.all
    sub_n_level_category_ids = self.sub_n_level_categories.map(&:id)
    sub_n_level_category_ids += [self.id] unless options[:should_include_current_post_category] == true
    
    posts_scoped
      .where(
        post_category_id: sub_n_level_category_ids.uniq
      )
  end

end