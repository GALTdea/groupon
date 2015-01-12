class ProductsController < ApplicationController
  def index
    @customer = Customer.find_by wxid: params[:wxid]

    if not @customer
      redirect_to new_customer_path
    else
      @order = @customer.orders.build

      @products = Product.available

      @order.products << @products
      @items = @order.items

      render 'list'
    end
  end
end
