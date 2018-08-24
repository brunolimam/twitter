Rails.application.routes.draw do
  # Authentication routes
  devise_for :users, :controllers => { registrations: 'registrations' }, :path => '/', except: [:edit]
  
  # Profile routes
  authenticated :user do
    root to: 'users#timeline', as: :authenticated_root
  end

  resources :users, only: [:show], param: :user_name, :path => '/' do
    # Following actions routes
    post '/follow', to: 'following_relations#follow'
    post '/unfollow', to: 'following_relations#unfollow'

    # Tweets routes
    resources :tweets do
      post '/like', to: 'likes#like'
      post '/dislike', to: 'likes#dislike'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'application#index'
end
