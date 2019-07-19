Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  namespace :api do
    get '/products' => 'products#index'
    post '/products' => 'products#create'
    get '/show_query' => 'products#show'
    get '/products/:id' => 'products#show'
    patch '/products/:id' => 'products#update'
    delete '/products/:id' => 'products#destroy'

    get '/suppliers' => 'suppliers#index'

    post '/users' => 'users#create'

    post '/sessions' => 'sessions#create'

    post '/orders' => 'orders#create'
    get '/orders' => 'orders#index'
    get '/orders/:id' => 'orders#show'

    post '/carted_products' => 'carted_products#create'
    get '/carted_products' => 'carted_products#index'
    get '/carted_products/:id' => 'carted_products#show'
    delete '/carted_products/:id' => 'carted_products#destroy'
  end

  get '/products' => 'products#index'
  get '/products/new' => 'products#new'
  post '/products' => 'products#create'
  get '/products/:id' => 'products#show'
  get '/products/:id/edit' => 'products#edit'
  patch '/products/:id' => 'products#update'
  delete '/products/:id' => 'products#destroy'

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end
end
