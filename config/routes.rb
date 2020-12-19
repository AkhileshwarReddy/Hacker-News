Rails.application.routes.draw do
  devise_for :users

  root to: "home#index"

  get "/submit", to: "submissions#new"
  post "/submissions/create", to: "submissions#create"
  get "/newest", to: "submissions#newest"
  get "/user", to: "users#user"
  patch "/user", to: "users#update"
end
