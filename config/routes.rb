Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  namespace :api do
    get "/products" => "products#show_products"
    get "/iphone" => "products#iphone_deets"
    get 'show_any_product_query' => 'products#show_any_product'
    get 'show_any_product_segment/:id' => 'products#show_any_product'
  end

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end
end
