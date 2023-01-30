class Public::CartItemsController < ApplicationController
  def index
    @customer = current_customer
    @cart_items = @customer.cart_items
    @cart_item = CartItem.new
    @cart_count = 0
    @cart_items.each do |cart_item|
      @cart_count += 1
      @cart_total = cart_total
    end

  end
  
  def cart_total
    cart_total = 0
    @customer.cart_items.each do |cart_item|
      cart_total += cart_item.subtotal
    end
    return cart_total
  end  
  
  def create
    @cart_item_new = CartItem.new(cart_item_params)
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item.present?
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      redirect_to cart_items_path
    else
      @cart_item_new.customer_id = current_customer.id
      if @cart_item_new.save
        redirect_to cart_items_path
      else
        redirect_to request.referer
      end
    end
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end  

end


