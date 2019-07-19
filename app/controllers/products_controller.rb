class ProductsController < ApplicationController
  def index
    @products = Product.all
    render 'index.html.erb'
  end

  def show
    @product = Product.find_by(id: params[:id])
    render 'show.html.erb'
  end

  def create
    @product = Product.new(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      supplier_id: params[:supplier_id]
    )

    @product.save

    redirect_to "/products/#{@product.id}"
  end

  def new
    render 'new.html.erb'
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name] || @product.name
    @product.price = params[:price] || @product.price
    @product.description = params[:description] || @product.description
    @product.supplier_id = params[:supplier_id] || @product.supplier_id
    @product.save
    if @product.save
      redirect_to "/products/#{@product.id}"
    else
      render 'errors.json.jb', status: :unprocessible_entity
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
    render 'edit.html.erb'
  end
end
