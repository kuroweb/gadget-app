Rails.application.routes.draw do
  namespace :v1 do
    get 'tags/search'
  end
  namespace :v1 do
    get '/isFollowed', to: 'relationships#isFollowed'
    resources :users do
      member do
        patch '/update_avatar', to: 'users#update_avatar'
        get '/following', to: 'users#following'
        get '/followers', to: 'users#followers'
        get '/posts', to: 'users#posts'
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :posts
  end
end