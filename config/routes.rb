Rails.application.routes.draw do
  # Authentication routes
  devise_for :users, :controllers => { registrations: 'registrations' }, :path => '/', except: [:edit]
  
  # Profile routes
  authenticated :user do
    root to: 'tweets#timeline', as: :authenticated_root
    post '/tweets', to: 'tweets#create'
  end

  resources :users, only: [:show], param: :user_name, :path => '/' do
    # Following actions routes
    post '/follow', to: 'following_relations#follow'
    post '/unfollow', to: 'following_relations#unfollow'

    # Tweets routes
    resources :tweets, only: [:show] do
      post '/like', to: 'tweets#like_handler'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#index'
end
