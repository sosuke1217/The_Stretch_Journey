Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    resources :searches, only: [:index]
    resources :comments, only: [:index, :destroy]
    resources :genres, only: [:new, :create, :index, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        put :deactivate
        put :activate
      end
    end
  end

  devise_for :users
  resources :posts do
    resource :like, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]
  
  resources :stretch_programs do
    resources :stretch_tags
  end
  resources :group_users, only: [:update]
  resources :groups do
    resources :group_comments
    member do
      get "join"
      delete "all_destroy"
      post 'join'
      post 'approve_request'
      post 'revoke_request'
      post 'leave'
    end
  end

  post 'guest_login', to: 'users#guest_login'
  
  get 'homes/top'
  get 'homes/about', to: 'homes#about', as: :about
  get "search" => "searches#search"
 
  root to: "homes#top"
end
