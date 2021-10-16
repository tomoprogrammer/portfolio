Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'

  resources :walks, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :walk_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
