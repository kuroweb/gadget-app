Rails.application.routes.draw do
  namespace :v1 do
    get '/isFollowed', to: 'relationships#isFollowed'
    get 'tags/search', to: 'tags#search'
    get 'users/search', to: 'users#search'
    get 'posts/search', to: 'posts#search'
    get 'users/isFollowed', to: 'users#isFollowed'
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
    resources :likes, only: [:create, :destroy]
  end
end