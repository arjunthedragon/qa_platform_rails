Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'static_pages#home'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource :static_pages, only: [] do
    collection do
      get :home
    end
  end

  resources :users, only: [:index, :show, :destroy, :update, :edit] do
    resources :badges, only: [:index, :show] do
    end

    resources :posts do
      member do
        get :favoured_users
        post :remove_tags
      end
    end

    member do
      get :answered_posts
      get :favourate_posts
    end
  end

  resources :posts, only: [:index, :show] do
    resources :answers do
      member do
        post :accept
        post :unaccept
      end
    end
  end

  resources :tags do
  end

  resources :tag_posts, only: [:destroy] do
  end

  resources :favourates do
  end

  resources :votes do
  end

  resources :edit_suggestions do
    member do
      post :reopen
      post :accept
      post :reject
    end
  end

  resources :comments do
  end

  resources :feedbacks do
  end

  resources :departments, only: [:index, :show] do
  end

  resources :post_categories, only: [:index, :show] do
    collection do
      get :is_popular
    end
  end

  resources :tags, only: [:index, :show] do
  end

  resources :post_visits, only: [:create] do
  end

end