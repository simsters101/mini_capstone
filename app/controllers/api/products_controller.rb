class Api::ProductsController < ApplicationController
  def show_products
    render 'products.json.jb'
  end
end
