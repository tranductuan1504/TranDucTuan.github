Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :products
  resources :products do
    resources :subscribers, only: [ :create ]
  end
  resource :unsubscribe, only: [ :show ]


  get "/products", to: "products#index"
  post "/products", to: "products#create"
  get "/products/:id", to: "products#show"
  get "/blog/:title", to: "blog#show"
  get "/blog/:slug", to: "blog#show"

  get "/products", to: "products#index"

  get "/products/new", to: "products#new"
  
  get "/products/:id", to: "products#show"

  get "/products/:id/edit", to: "products#edit"
  patch "/products/:id", to: "products#update"
  put "/products/:id", to: "products#update"

  delete "/products/:id", to: "products#destroy"

  root "products#index"
end