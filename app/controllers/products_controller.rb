class ProductsController < ApplicationController
  def index
    @customer = Customer.find(params[:customer_id])
    @order = @customer.orders.build

    @products = Product.available

    @order.products << @products
    @items = @order.items

    render 'list'
  end
end
