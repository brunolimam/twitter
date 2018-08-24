Rails.application.routes.draw do

  root to: 'application#index'
  
  # Authentication routes
  devise_for :users, :controllers => { registrations: 'registrations' }, :path => '/', except: [:edit]
  
  # Profile routes
  resources :users, only: [:show], param: :user_name, :path => '/' do
    # Following actions routes
    post '/follow', to: 'following_relations#follow'
    post '/unfollow', to: 'following_relations#unfollow'
  
    # Tweets routes
    resources :tweets
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
