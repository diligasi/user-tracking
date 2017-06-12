Rails.application.routes.draw do
  root 'contact#index'

  post '/cookie', to: 'tracker#cookie_handler'
end
