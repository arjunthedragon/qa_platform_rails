ActiveAdmin.register PostCategory do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :id, :name, :description, :parent_category_id, :department_id
                
  
  filter :id
  filter :name, as: :string
  filter :description, as: :string
  filter :parent_post_category
  filter :sub_post_categories
  filter :department
  filter :created_at, as: :date_range

  show do |post_category|
    attributes_table do
      row :id
      row :description
      row :parent_post_category
      row :department
      row :sub_post_categories do |product_category|
        bullet_list(post_category.sub_post_categories.map(&:name), nil)
      end
      row :created_at
    end
  end

  form do |f|
    f.input :name
    f.input :description

    @post_categories = PostCategory.all + [PostCategory.new(:name => PostCategory::POST_CATEGORY_ROOT)]
    unless f.object.new_record?
      @post_categories -= [PostCategory.find(f.object.id)]
      @post_categories -= f.object.sub_n_level_categories
    end

    f.input :parent_category_id, collection: @post_categories, as: :select, label: "Parent Category (None means root i.e ALL): "
    #f.input :parent_category
    f.input :department
    f.actions
  end
  
end
