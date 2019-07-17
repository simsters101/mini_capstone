class Api::CartedProductsController < ApplicationController
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
end
