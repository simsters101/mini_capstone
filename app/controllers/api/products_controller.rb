class Api::ProductsController < ApplicationController
  def show_products
    @products = Product.all
    render 'products.json.jb'
  end

  def iphone_deets
    @iphone = Product.find_by(name: "iPhone XS Max")
    render 'iphone.json.jb'
  end

  def show_any_product
    product = params["id"]
    @info = Product.find_by(id: product)
    render 'show_a_product.json.jb'
  end
end
