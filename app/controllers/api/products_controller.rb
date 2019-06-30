class Api::ProductsController < ApplicationController
  def index
    @products = Product.all
    render 'index.json.jb'
  end

  def iphone_deets
    @iphone = Product.find_by(name: "iPhone XS Max")
    render 'iphone.json.jb'
  end

  def show
    the_id = params["id"]
    @info = Product.find_by(id: the_id)
    render 'show.json.jb'
  end
end
