class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    @order.code = "%X" % DateTime.now.strftime('%Q')

    if @order.items.empty? or @order.save
      redirect_to customer_orders_path
    else
      render plain: 'save return false'
    end

  end

  def edit
    @customer = Customer.find(params[:customer_id])
    @order = Order.find(params[:id])
    render 'edit'
  end

  def show

  end

  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders

    render 'index'
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(order_params)
      redirect_to customer_orders_path
    else
      render plain: 'false'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      redirect_to customer_orders_path
    else
      render plain: 'false'
    end
  end

  private
    def order_params
      params.require(:order).permit(:customer_id, :payment, :delivery, items_attributes: [:id, :amount, :product_id, :_destroy])
    end

end
