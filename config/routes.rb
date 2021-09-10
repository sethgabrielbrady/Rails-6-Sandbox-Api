Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts

      post 'authenticate', to: 'authentication#create'
    end
  end

  post 'refresh', controller: :refresh, action: :create
  #move these to a sessions controller
  post 'signin', controller: :signin, action: :create
  post 'signup', controller: :signup, action: :create
  delete 'signin', controller: :signin, action: :destroy
end
