Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  namespace :api do
    get '/products' => 'products#index'
    post 'products' => 'products#create'
    get 'show_query' => 'products#show'
    get 'products/:id' => 'products#show'
    patch 'products/:id' => 'products#update'
    delete 'products/:id' => 'products#destroy'
  end

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end
end
