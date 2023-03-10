class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customers = current_customer
    @customers.update(customer_params)
    redirect_to customers_mypage_path
  end
  
  def cancel
  end
  
  def close
    @customer = current_customer
    @customer.update(is_deleted: true)
    sign_out
    redirect_to root_path
  end  
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
  end  
end
