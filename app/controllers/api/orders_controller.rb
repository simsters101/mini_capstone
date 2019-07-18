class Api::OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    carted_products = current_user.carted_products
    carted_products = carted_products.where(status: "carted")

    subtotal = 0
    tax = 0
    carted_products.each do |carted_product|
      subtotal += carted_product.product.price * carted_product.quantity
      tax += carted_product.product.tax * carted_product.quantity
    end

    @order = Order.new(
      user_id: current_user.id,
      subtotal: subtotal,
      tax: tax,
      total: subtotal + tax
    )

    if @order.save
      carted_products.each do |carted_product|
        carted_product.status = "purchased"
        carted_product.order_id = @order.id
        carted_product.save
      end
      render 'show.json.jb', status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :unauthorized
    end
  end

  def index
    @orders = current_user.orders
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
