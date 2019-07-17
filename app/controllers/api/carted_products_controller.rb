class Api::CartedProductsController < ApplicationController
  before_action :authenticate_user

  def create
    @carted_product = CartedProduct.new(
      status: "carted",
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity]
    )

    if @carted_product.save
      render 'show.json.jb'
    else
      render json: {}, status: :unauthorized
    end
  end

  def index
    @carted_products = current_user.carted_products
    @carted_products = @carted_products.where(status: "carted")
    render 'index.json.jb'
  end

  def show
    @carted_product = CartedProduct.find_by(id: params[:id])
    if current_user.id == @carted_product.user_id
      render 'show.json.jb'
    else
      render json: {message: "You cannot see someone elses carted_product!"}, status: :unauthorized
    end
  end

  def destroy
    @carted_product = CartedProduct.find_by(id: params[:id])
    if current_user.id == @carted_product.user_id
      @carted_product.status = "removed"
      @carted_product.save
      render 'show.json.jb'
    else
      render json: {message: "You cannot delete someone elses carted_product!"}, status: :unauthorized
    end
  end
end
