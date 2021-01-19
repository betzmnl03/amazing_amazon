Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get('/home',{to: "welcome#home"})


  resources :products do
    resources :reviews
  end
  resources :users, only:[:new, :create]
  resources :admin
  resource :session, only:[:new, :create, :destroy]
    
end
