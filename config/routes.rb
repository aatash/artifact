Rails.application.routes.draw do

  resources :posts
  get 'home/index'
  devise_for :users

  devise_scope :user do
    root to: "home#index"
  end

end
