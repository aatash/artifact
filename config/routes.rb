Rails.application.routes.draw do

  resources :posts
  get 'posts/index'
  devise_for :users

  devise_scope :user do
    root to: "posts#index"
  end

end
