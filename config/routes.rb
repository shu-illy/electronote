Rails.application.routes.draw do
  root 'static_pages#home'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  get '/healthcheck' => lambda { |env| [200, { 'Content-Type' => 'text/plain' }, ['Healthy']] }
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :works, only: [:new, :create, :destroy]
end
