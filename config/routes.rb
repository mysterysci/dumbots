Rails.application.routes.draw do
  root 'arena#show'

  post '/arena', to: 'arena#move'
  post '/new', to: 'arena#new'
end
