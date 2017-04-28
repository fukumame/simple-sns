Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'feeds#index'
  resources :feeds, only: :index
  resources :posts, only: [:create], shallow: true do
    get :like, on: :member
    get :unlike, on: :member
    resources :replies, only: [:index, :create] do
      get :like, on: :member
      get :unlike, on: :member
    end
  end

  resources :followers, only: :index

  resources :users, only: [:index, :show] do
    get :follow, on: :member
    get :unfollow, on: :member
    resources :posts, only: :index
  end
end
