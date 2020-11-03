Rails.application.routes.draw do
  namespace :v1 do
    get '/isFollowed', to: 'relationships#isFollowed'
    resources :users, only: [:index, :show, :create, :update, :destroy] do
      member do
        patch '/update_avatar', to: 'users#update_avatar'
      end
    end
    resources :relationships, only: [:create, :destroy]
  end
end