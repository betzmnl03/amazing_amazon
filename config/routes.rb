Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get('/home',{to: "welcome#home"})


  resources :products do
    
    resources :reviews do
    
    end
    get :liked, on: :collection

    resources :favourites, shallow: true, only: [:create, :destroy]
    get :favourited, on: :collection

    # get :tagged, on: :collection
    # resources :tags
    

  end

  
  resources :likes, only: [:create, :destroy]
  resources :votes, only: [:create, :destroy] do
    get :voted, on: :collection  
  end
  resources :tags, only:[:index, :show]
  resources :favourites, only:[:create]
  resources :users, only:[:new, :create]
  resources :admin
  resource :session, only:[:new, :create, :destroy]
    
end
