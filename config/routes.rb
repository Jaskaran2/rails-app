Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "articles#index"
  resources :articles do
    resources :comments
  end


  get "sign_up", to:"registrations#new"
  post "sign_up", to:"registrations#create"

  get "sign_in", to:"registrations#newuser"
  post "sign_in", to:"registrations#createuser"

  get "password", to:"passwords#edit", as: :edit_password
  patch "password", to:"passwords#update"

  delete "/logout", to:"registrations#destroy"

  get "password/reset", to:"password_resets#new"
  post "password/reset", to:"password_resets#create"
  get "password/reset/edit", to:"password_resets#edit"
  patch "password/reset/edit", to:"password_resets#update"

  get "articles/my/archived", to:"articles#archived"
  get "articles/my/all", to:"articles#myall"


end
