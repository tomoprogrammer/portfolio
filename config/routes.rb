Rails.application.routes.draw do
  get 'calendars/index'
  devise_for :users
  root to: 'homes#top'

  get 'home/about' => 'homes#about'

  get '/search', to: 'searches#search'

  resources :walks, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :walk_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :index, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :calendars, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
