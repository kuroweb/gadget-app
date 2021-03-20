Rails.application.routes.draw do

  ################################################################################################
  # V2
  ################################################################################################
  namespace :v2 do
    resources :users do
      get :search, on: :collection
      member do
        patch '/update_avatar', to: 'users#update_avatar'
        get '/following', to: 'users#following'
        get '/followers', to: 'users#followers'
        get '/posts', to: 'users#posts'
        # 以下管理者用
        get '/guestmode', to: 'users#guestmode'
        get '/adminmode', to: 'users#adminmode'
        get '/userinfo', to: 'users#userinfo'
        get '/userdelete', to: 'users#userdelete'
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :posts do
      get :search, on: :collection
    end
    resources :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    resources :boards do
      get :search, on: :collection
    end
    resources :board_comments
    resources :tags do
      get :search, on: :collection
    end
    resources :user_tag_maps, only: [:create, :destroy]
    resources :tasks, only: :index
    resources :notices, only: [:index] do
      get :unchecked, on: :collection
      get :checked, on: :collection
    end
    resources :gadgets, only: [:index, :create, :show, :update, :destroy] do
      get :search, on: :collection
    end
  end

  ################################################################################################
  # V1
  ################################################################################################
  namespace :v1 do
    resources :users do
      get :search, on: :collection
      member do
        patch '/update_avatar', to: 'users#update_avatar'
        get '/following', to: 'users#following'
        get '/followers', to: 'users#followers'
        get '/posts', to: 'users#posts'
        # 以下管理者用
        get '/guestmode', to: 'users#guestmode'
        get '/adminmode', to: 'users#adminmode'
        get '/userinfo', to: 'users#userinfo'
        get '/userdelete', to: 'users#userdelete'
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :posts do
      get :search, on: :collection
    end
    resources :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    resources :boards do
      get :search, on: :collection
    end
    resources :board_comments
    resources :tags do
      get :search, on: :collection
    end
    resources :user_tag_maps, only: [:create, :destroy]
    resources :tasks, only: :index
    resources :notices, only: [:index] do
      get :unchecked, on: :collection
      get :checked, on: :collection
    end
    resources :gadgets, only: [:index, :create, :show, :update, :destroy] do
      get :search, on: :collection
    end
  end
end