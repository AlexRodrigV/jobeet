Rails.application.routes.draw do

  post 'home/addEnterprise'

  get 'offers' => 'offers#home'
  get 'offers/:id' => 'offers#show'
  patch 'offers/:id' => 'offers#apply'
  post 'offers/:id' => 'offers#unsuscribe'

  get 'enterprise' => 'enterprise#index'
  get 'enterprise/newOffer'
  post 'enterprise' => 'enterprise#create'
  get 'enterprise/:id' => 'enterprise#show'
  get 'enterprise/delete/:id' => 'enterprise#delete'
  patch 'enterprise/:id' => 'enterprise#update'
  get 'enterprise/update/:id' => 'enterprise#change'
  post 'enterprise/update' => 'enterprise#update'


  get 'profil/:id' => 'profil#index'

  get 'home/index'
  get 'chat/index', to: 'chat#index'
  get 'sessions/index'
  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')

  post 'home/signout' => 'home#signout'
  post 'home/applicant' => 'home#applicant'
  post 'home/recruiter' => 'home#recruiter'

  post 'profil' => 'profil#edit'

  resources :offers
  resources :annuaire
  resources :users
  resources :chat, only: %i[index]

  root 'home#index'

end
