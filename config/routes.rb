Rails.application.routes.draw do
  root 'welcome#index'
  get "/auth/:provider/callback" => "users#spotify"
  get "/signout" => "authentications#signout", as: :signout
  resources :dashboard
  resources :users do
    resources :comparisons do
      get 'by_artist', on: :collection
    end
  end

end
