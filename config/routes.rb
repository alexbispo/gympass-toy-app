Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "pages#home"
  # resources :users, only: [:new, :create]
  get "/signup" => "signup#new"
  post "/signup" => "signup#create"

  get "/confirmation" => "confirmation#show"

  get "/login" => "login#new"
  post "/login" => "login#create"
  delete "/logout" => "login#destroy"

  resources :gyms, only: [:new, :create, :index, :destroy]
  patch "/gym/:id/approve" => "gyms#approve", as: :approve_gym
end
