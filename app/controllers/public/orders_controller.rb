class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def delivery_charge
    @delivery_charge = 800
  end  
  
  def cart_total
    cart_total = 0
    current_customer.cart_items.each do |cart_item|
      cart_total += cart_item.subtotal
    end
    return cart_total
  end


  def confirm
    @order =Order.new(order_params)
    @customer = current_customer
    @cart_total = cart_total
    @delivery_charge = delivery_charge
    @all_total = @cart_total + @delivery_charge
    if params[:order][:select_address] == "0"
    @selected_address = Address.create(customer_id: @customer, name: @customer.last_name + @customer.first_name, address: @customer.address, postal_code: @customer.postal_code)  
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    @selected_address = @customer
    else params[:order][:select_address] == "1"
      @selected_address = @order
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.billing_amount = cart_total + delivery_charge
    @order.customer_id = current_customer.id
    @order.delivery_charge = delivery_charge
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderItem.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.cost = cart_item.item.with_cost
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
    
    current_customer.cart_items.destroy_all
    redirect_to orders_finish_path
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_items
  end
  
  def finish
  end
  
  def index
    @customer = current_customer
    @orders = @customer.orders.order(created_at: :desc)
  end  
  
  private
  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name)
  end  
end
