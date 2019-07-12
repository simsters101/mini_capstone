class Api::OrdersController < ApplicationController
  def create
    if current_user
      order = Order.new(
        user_id: current_user.id, 
        product_id: params[:product_id],
        quantity: params[:quantity],
      )

      if order.save
        render json: {message: 'Order created successfully'}, status: :created
      else
        render json: {errors: user.errors.full_messages}, status: :bad_request
      end

      order.update(
        subtotal: order.product.price,
        tax: order.product.tax,
        total: order.product.price + order.product.tax
      )
    else
      render json: {message: "You must be signed in to make an order."}, status: :bad_request
    end
  end

  def index
    if current_user
      render 'index.json.jb'
    else
      render json: {message: "Sign in to see your orders."}, status: :bad_request
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
    if current_user
      if @order.user_id == current_user.id
        render 'show.json.jb'
      else
        render json: {message: "You can only see your orders! No one elses."}, status: :bad_request
      end
    else
      render json: {message: "Sign in to see orders."}, status: :bad_request
    end
  end
end
