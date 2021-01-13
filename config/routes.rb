Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get('/home',{to: "welcome#home"})
  get('/about',{to: "welcome#about"})

  # get('/products/new', to: "products#new", as: :new_product)
# post('/products', to: "products#create")

#   get('/products/:id', to: 'products#show', as: :question)

  delete("/questions/:id",to: "questions#destroy")

  resources :products

end
