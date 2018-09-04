Rails.application.routes.draw do
  # Authentication routes
  devise_for :users, :controllers => { registrations: 'registrations' }, :path => '/', except: [:edit]
  
  # Profile routes
  authenticated :user do
    root to: 'tweets#timeline', as: :authenticated_root
    post '/tweets', to: 'tweets#create'
    get '/mentions', to: 'users#mentions'
  end

  resources :users, param: :user_name, only: [:show], :path => '/' do
    member do
      post '/follow', to: 'users#follow'
      post '/unfollow', to: 'users#unfollow'
    end

    # Tweets routes
    resources :tweets, only: [:show, :destroy] do
      post '/like', to: 'tweets#like_handler'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#index'
end
