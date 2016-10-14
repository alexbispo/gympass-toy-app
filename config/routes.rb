Rails.application.routes.draw do
  root "pages#home"
  get "/search/gyms" => "pages#search", as: :home_search

  get "/signup" => "signup#new"
  post "/signup" => "signup#create"

  get "/confirmation" => "confirmation#show"

  get "/login" => "login#new"
  post "/login" => "login#create"
  delete "/logout" => "login#destroy"

  resources :gyms, only: [:new, :create, :index, :destroy, :show]
  patch "/gym/:id/approve" => "gyms#approve", as: :approve_gym

  post "/daily_token" => "daily_token#create"
  get "/daily_tokens" => "daily_token#index"
  patch "/daily_token/:id/validate" => "daily_token#validate", as: :validate_token
end
