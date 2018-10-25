Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/alerts' => 'alerts#create'
  get '/alerts' => 'alerts#list'
  put '/alerts' => 'alerts#update'
  put '/alerts/:reference_id' => 'alerts#update'
end
