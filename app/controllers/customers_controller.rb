class CustomersController < ApplicationController

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer
    else
      render 'new'
    end

  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find_by wxid: params[:customer][:wxid]
    if @customer.update(customer_params)
      redirect_to @customer
    else
      render 'edit'
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:nickname, :name, :mobile, :qq, :wxid, orders_attributes: [:customer_id, :_destroy])
    end
end