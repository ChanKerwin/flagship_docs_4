Rails.application.routes.draw do

  root to: "categories#index"

  resources :groups do 
    member do
      post :add_member
    end
    resources :memberships, only: [:new, :create, :update, :destroy] do
      member do
        get :promote
        get :demote
      end
    end
  end

  resources :users, except: [:new, :create] do
    member do
      get :admin_status
      get :manage_groups
    end
  end

  resources :documents, except: [:index] do
    member do 
      get :download
    end
    collection do
      get :search
      post :search
    end

    resources :revisions, only: [:create, :destroy] do
      member do
        get :download
      end
    end
  end 

  resources :categories do
    member do
      get :subcategories
    end
    collection do 
      get :manage
    end
  end

  get '/auth/:provider/callback', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'

end