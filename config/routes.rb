Rails.application.routes.draw do
  root to: redirect('/devices')

  resources :devices

  resources :firmwares do
    member do
      get 'content', to: 'firmwares#content'
    end
  end

  resources :products do
    member do
      get 'firmware/:fqbn', to: 'products#firmware'
      patch 'firmware/:fqbn', to: 'products#set_firmware'
    end
  end

  resource :session, only: [:create, :destroy]

  resources :tokens

  resource :user, only: [:show, :update]

  resources :board_types, only: [:index] do
    member do
      get 'versions', to: 'board_types#versions'
    end
  end
end
