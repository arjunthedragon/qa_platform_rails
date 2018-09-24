ActiveAdmin.register User do
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

  permit_params :password, :password_confirmation,
                profile_attributes: [:first_name, :last_name, :dob,
                                     image_attributes: [:file]]

  actions :all, :except => [:edit, :update, :new, :destroy]

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do |user|
    attributes_table do
      row :email
      row :phone_number
    end

    panel 'Profile' do
      attributes_table_for user.profile do
        row :first_name
        row :last_name
      end
    end
  end

  form do |f|
    f.inputs 'Password' do
      f.input :password
      f.input :password_confirmation
    end

    f.object.profile || f.object.build_profile
    f.inputs 'Profile', for: :profile do |profile|
      profile.input :first_name
      profile.input :last_name
      profile.input :dob, as: :string, input_html: {class: 'datepicker'}

      profile.object.image || profile.object.build_image
      profile.inputs 'Image', for: :image do |image|
        image.input :file, :hint => image.template.image_tag(image.object.file.url)
      end
    end

    f.actions
  end

  action_item :only => :show do |user|
    if !user.nil?
      if user.is_suspended?
        link_to 'Reinstate User', reinstate_admin_user_path(user), method: :put
      else
        link_to 'Suspend User', suspend_admin_user_path(user), method: :put
      end
    end
  end

  member_action :suspend, method: :put do
    resource.suspend!
    redirect_to resource_path, notice: "Suspended"
  end

  member_action :reinstate, method: :put do
    resource.reinstate!
    redirect_to resource_path, notice: "Reinstated"
  end

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end

  end

end
