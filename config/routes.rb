Rails.application.routes.draw do
  devise_for :users
  
  root "users#index"
  # root "devise/registrations#new"
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
    end
  end
end