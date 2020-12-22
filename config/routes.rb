Rails.application.routes.draw do
  devise_for :users

  root to: "submissions#newest"

  get "/submit", to: "submissions#new"
  post "/submissions/create", to: "submissions#create"
  get "/newest", to: "submissions#newest"
  get "/user", to: "users#user"
  patch "/user", to: "users#update"
  get "/item", to: "submissions#display_submission"
  post "/comment/create", to: "comments#create"
  get "/hide", to: "submissions#hide"
  get "/hidden", to: "submissions#hidden"
  get "/ask", to: "submissions#askhn"
  get "/show", to: "submissions#showhn"
  get "/shownew", to: "submissions#shownew"
  get "/submitted", to: "submissions#submitted"
  get "/vote", to: "votes#vote"
  get "/upvoted", to: "votes#upvoted"
end
