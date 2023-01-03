Rails.application.routes.draw do
  get '/', to: 'crons#start'

  post '/users', to: 'crons#new_user'
end
