Rails.application.routes.draw do
  root "home#index"

  get "daily/:month/:day/:year", to: "home#daily", as: "daily"

  resources :entries

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "signup", to: "users#signup"
      post "login", to: "users#login"

      get "/entries", to: "entries#index"
      post "/entries/add", to: "entries#create"
      put "/entries/:id", to: "entries#update"
      delete "/entries/:id", to: "entries#destroy"
      get "/daily/:month/:day/:year", to: "entries#daily"
    end
  end
end
