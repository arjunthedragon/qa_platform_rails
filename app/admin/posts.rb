ActiveAdmin.register Post do
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
    column :title
    column :description do |post|
      post.question.description
    end
    column :posted_by do |post|
      post.user
    end
    column :net_votes do |post|
      post.question.net_votes_count
    end
    column :post_category
    column :tags do |post|
      post.tags
    end
    column :status
    column :created_at
    column :updated_at

    actions
  end

  filter :title, as: :string
  filter :net_votes_count
  filter :id
  filter :user_id
  filter :created_at, as: :date_range
  filter :tags
  
  show do |post|
    attributes_table do
      row :id
      row :description do
        post.question.description
      end
      row :user
      row :net_votes_count
      row :post_category
      row :tag_ids
      row :created_at
      row :status
    end

    panel 'Answers' do
      table_for post.answers do |answer|
        column :description
        column :user
        column "Upvotes Received" do
          answer.answer_upvotes.count
        end
        column "Downvotes Received" do
          answer.answer_downvotes.count
        end
        column "Net Votes" do
          answer.net_votes_count
        end

        column :created_at
        column :updated_at
      end
    end

    panel 'Comment' do
      table_for post.comments do |comment|
        column :description
        column :commented_by
        column :created_at
        column :updated_at

      end
    end

    panel 'Feedback' do
      table_for post.feedbacks do |feedback|
        column :feedback_type
        column :user
        column :created_at
      end
    end
  end

end
