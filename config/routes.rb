Rails.application.routes.draw do
  get 'home/index'

  resources :offers

  root 'home#index'
end
