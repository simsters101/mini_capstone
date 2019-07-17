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

  def destroy
    if current_user == User.find_by(id: params[:carted_product])
      carted_product = CartedProduct.find_by(id: params[:carted_product])
      carted_product.status = "removed"
      carted_product.save
    end
  end
end
