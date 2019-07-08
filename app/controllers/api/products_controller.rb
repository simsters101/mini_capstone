class Api::ProductsController < ApplicationController
  def index
    if params[:search]
      puts "I am in the search compartment"
      @products = Product.where("name LIKE ?", "%#{params[:search]}%")
    elsif params[:discount] == "true"
      puts "I am in the discount compartment"
      @products = Product.where("price < ?", "300")
    elsif params[:sort] == "price" && params[:sort_order] == "desc"
      puts "I am in the default sorting compartment which is ascending"
      @products = Product.order('price DESC')
    elsif params[:sort] == "price"
      puts "I am in the descending sorting compartment"
      @products = Product.order('price')
    else
      puts "I am in the default all products compartment"
      @products = Product.all
    end
    render 'index.json.jb'
  end

  def show
    @product = Product.find_by(id: params["id"])
    render 'show.json.jb'
  end

  def create
    @product = Product.new(
      name: params[:name], 
      price: params[:price],
      description: params[:description],
      image_url: params[:image_url]
      )
    if @product.save
      render 'show.json.jb'
    else
      render 'errors.json.jb', status: :unprocessible_entity
    end
  end

  def update
    @product = Product.find_by(id: params["id"])
    @product.name = params[:name] || @product.name
    @product.price = params[:price] || @product.price
    @product.description = params[:description] || @product.description
    @product.image_url = params[:image_url] || @product.image_url
    @product.save
    if @product.save
      render 'show.json.jb'
    else
      render 'errors.json.jb', status: :unprocessible_entity
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    render 'destroy.html'
  end
end
