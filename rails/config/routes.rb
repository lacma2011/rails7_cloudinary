Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  jsonapi_resources :people

  get '/signatures/new', to: 'signatures#new'
  post '/signatures/processUpload', to: 'signatures#processUpload'

  get '/images', to: 'images#getAll'
  
end
