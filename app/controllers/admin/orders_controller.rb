class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order.delivery_charge = 800
  end
end
