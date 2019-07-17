class Api::OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    order = Order.new(
      user_id: current_user.id, 
      product_id: params[:product_id],
      quantity: params[:quantity]
    )

    if order.update(
      subtotal: order.product.price * params[:quantity].to_i, 
      tax: order.product.tax * params[:quantity].to_i,
      total: (order.product.price * params[:quantity].to_i) + (order.product.tax * params[:quantity].to_i)
    )
      render json: {message: 'Order created successfully'}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :unauthorized
    end

  end

  def index
    render 'index.json.jb'
  end

  def show
    @order = Order.find_by(id: params[:id])
    if @order.user_id == current_user.id
      render 'show.json.jb'
    else
      render json: {message: "You can only see your orders! No one elses!"}, status: :unauthorized
    end
  end
end
