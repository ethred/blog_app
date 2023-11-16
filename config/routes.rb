Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v1 do
  #     resources :users do
  #       resources :user_posts, only: [:index]
  #       resources :posts do
  #         resources :post_comments, only: [:index]
  #         resources :comments
  #         resources :likes
  #         post 'comments', to: 'add_comment#create'  # Adjusted route
  #       end
  #     end
  #   end
  # end

  devise_for :users, controllers: { registrations: 'registrations', passwords: 'passwords',  sessions: 'sessions' }
  
  root "users#index"
  # root "devise/registrations#new"
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts do
          get 'comments', to: 'comments#comments_for_post'
        end
      end
      root 'users#index'
    end
  end
  
end