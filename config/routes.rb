Rails.application.routes.draw do
  get 'profil/index'
  get 'home/index'
  get 'sessions/index'
  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')

  resources :offers
  resources :users

  root 'home#index'

end
