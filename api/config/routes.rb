Rails.application.routes.draw do
  namespace :v1 do
    resources :users, only: [:index, :show, :create, :update, :destroy] do
      member do
        patch '/update_avatar', to: 'users#update_avatar'
      end
    end
  end
end