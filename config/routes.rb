Rails.application.routes.draw do
  resources :devices

  resources :firmwares do
    member do
      get 'content', to: 'firmwares#content'
    end
  end

  resources :products

  post 'session', to: 'sessions#create'
  delete 'session', to: 'sessions#destroy'

  resources :tokens
end
