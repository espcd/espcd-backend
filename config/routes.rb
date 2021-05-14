Rails.application.routes.draw do
  resources :devices
  resources :firmwares do
    member do
      get 'content', to: 'firmwares#content'
    end
  end
  resources :products
end
