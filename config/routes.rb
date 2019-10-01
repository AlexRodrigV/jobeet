Rails.application.routes.draw do

  get 'offers' => 'offers#home'
  get 'offers/:id' => 'offers#show'
  patch 'offers/:id' => 'offers#apply'

  get 'enterprise' => 'enterprise#index'
  post 'enterprise' => 'enterprise#create'
  get 'enterprise/:id' => 'enterprise#show'
  patch 'enterprise/:id' => 'enterprise#update'

  get 'profil/index'

  get 'home/index'
  get 'sessions/index'
  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')

  post 'home/signout' => 'home#signout'
  post 'home/applicant' => 'home#applicant'
  post 'home/recruiter' => 'home#recruiter'

  resources :users

  root 'home#index'

end
