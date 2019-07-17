class Api::ProductsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :destroy]
  before_action :authenticate_admin, only: [:create, :update, :destroy]

  def index

    if params[:category]
      category = Category.find_by(name: params[:category])
      @products = category.products
    end

    if params[:search] && params[:discount] == "true"
      @products = Product.where("name LIKE ?", "%#{params[:search]}%").where("price < ?", "300")
    elsif params[:search]
      puts "I am in the search compartment"
      @products = Product.where("name LIKE ?", "%#{params[:search]}%")
    elsif params[:discount] == "true"
      puts "I am in the discount compartment"
      @products = Product.where("price < ?", "300")
    else
      @products = Product.all
    end

    # if params[:category]
    #   @products = @products.find_by_sql("SELECT * FROM products WHERE product.category.name = #{params[:category]}")
    # end

    if params[:sort] && params[:sort_order]
      @products = @products.order(params[:sort] => params[:sort_order])
    else
      @products = @products.order(:id)
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
      supplier_id: params[:supplier_id]
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
    @product.supplier_id = params[:supplier_id] || @product.supplier_id
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
