Rails.application.routes.draw do
  resources :devices
  resources :firmwares
  resources :firmwares, only: %i[create show] do
    get :content, on: :member
  end
end
