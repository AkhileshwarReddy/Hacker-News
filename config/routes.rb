Rails.application.routes.draw do
  devise_for :users

  root to: "submissions#newest"

  get "/submit", to: "submissions#new"
  post "/submissions/create", to: "submissions#create"
  get "/newest", to: "submissions#newest"
  get "/user", to: "users#user"
  patch "/user", to: "users#update"
  get "/item", to: "submissions#display_submission"
end
