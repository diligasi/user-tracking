require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  root 'contact#index'

  mount Sidekiq::Web => '/sidekiq'

  post '/cookie', to: 'tracker#cookie_handler'
  post '/contacts', to: 'contact#create'
  get '/contacts/:id', to: 'contact#show'
end
