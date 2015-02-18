Rails.application.routes.draw do
  root 'welcome#index'
  get "/auth/:provider/callback" => "users#spotify"
  resources :dashboard
  resources :users
  resources :peoples
end
