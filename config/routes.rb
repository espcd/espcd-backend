Rails.application.routes.draw do
  resources :devices

  resources :firmwares do
    member do
      get 'content', to: 'firmwares#content'
    end
  end

  resources :products do
    member do
      get 'firmware', to: 'products#firmware'
    end
  end

  post 'session', to: 'sessions#create'
  delete 'session', to: 'sessions#destroy'

  resources :tokens

  get 'user', to: 'users#show'
  patch 'user', to: 'users#update'
end
