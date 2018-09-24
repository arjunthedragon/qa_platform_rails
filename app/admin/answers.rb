ActiveAdmin.register Answer do
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

  actions :all, :except => [:edit, :update, :new, :destroy]


  index do
    selectable_column
    id_column
    column :description
    column :answered_by
    column :net_votes do |answer|
      answer.net_votes_count
    end
    column :post_id
    column :created_at
    column :updated_at

    actions
  end

  filter :description, as: :string
  filter :net_votes_count
  filter :post_id
  filter :answered_by_id
  filter :created_at, as: :date_range
  filter :created_at, as: :date_range

  show do |answer|
    attributes_table do
      row :description
      row :answered_by
    end

    panel 'Post' do
      attributes_table_for answer.post do
        row :title
        row "Description" do
          answer.post.question.description
        end
        row :user
        row "Upvotes Received" do
          answer.post.question_upvotes.count
        end
        row "Downvotes Received" do
          answer.post.question_downvotes.count
        end
        row "Net Votes" do
          answer.net_votes_count
        end

        row :post_category
        row :created_at
        row :updated_at
      end
    end

    panel 'Comment' do
      table_for answer.comments do |comment|
        column :description
        column :commented_by
        column :created_at
        column :updated_at

      end
    end

    panel 'Feedback' do
      table_for answer.feedbacks do |feedback|
        column :feedback_type
        column :user
        column :created_at
      end
    end
  end

end
