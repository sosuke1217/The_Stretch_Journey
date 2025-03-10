Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resource :like, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      put :deactivate
      put :activate
    end
  end
  
  resources :stretch_programs do
    resources :stretch_tags
  end
  
  get 'homes/top'
  get 'homes/about', to: 'homes#about', as: :about
 
root to: "homes#top"
end
