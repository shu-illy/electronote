Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#top'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  resources :users
  get '/healthcheck' => lambda { |env| [200, { 'Content-Type' => 'text/plain' }, ['Healthy']] }
end
