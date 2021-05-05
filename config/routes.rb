Rails.application.routes.draw do
  resources :devices
  resources :firmwares do
    member do
      get 'content', to: 'firmwares#get_content'
      post 'content', to: 'firmwares#set_content'
    end
  end
end
