Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts

      post 'authenticate', to: 'authentication#create'
    end
  end
end
