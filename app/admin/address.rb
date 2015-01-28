ActiveAdmin.register Address do

  permit_params :id, :area, :address

  config.batch_actions = true

  filter :area
  filter :created_at

  index do
    selectable_column
    id_column
    column("Customer") {|address| address.customer.name}
    column("Nickname") {|address| address.customer.nickname}
    column("mobile")   {|address| address.customer.mobile}
    column :area
    column :address
    column :created_at
    actions
  end

  # index do
  #   selectable_column
  #   column("Order", :sortable => :id) {|order| link_to "##{order.code} ", admin_order_path(order) }
  #   column("State")                   {|order| status_tag(order.status) }
  #   column("Payment")                 {|order| status_tag(order.payment) }
  #   column("Delivery")                {|order| status_tag(order.delivery) }
  #   column("Date", :created_at)
  #   column("Customer", :customer, :sortable => :customer_id)
  #   column("Total")                   {|order| number_to_currency order.total}
  #   actions
  # end
  #sidebar "Active Admin Demo" do
  #  render('/admin/sidebar_links', :model => 'users')
  #end
end

