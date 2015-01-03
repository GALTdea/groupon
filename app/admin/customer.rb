ActiveAdmin.register Customer do

  permit_params :nickname, :name, :mobile, :qq, :wxid

  config.batch_actions = true

  filter :name
  filter :nickname
  filter :mobile
  filter :qq
  filter :created_at

  index do
    selectable_column
    id_column
    column :nickname
    column :name
    column :created_at
    actions
  end

  show :title => :nickname do
    panel "Order History" do
      table_for(customer.orders) do
        column("Order", :sortable => :id) {|order| link_to "##{order.id}", admin_order_path(order) }
        column("State")                   {|order| status_tag(order.status) }
        column("Date", :sortable => :created_at){|order| pretty_format(order.created_at) }
        column("Total")                   {|order| number_to_currency order.total }
      end
    end
    active_admin_comments
  end

  sidebar "Customer Details", :only => :show do
    attributes_table_for customer, :nickname, :name, :mobile, :qq,  :created_at
  end

  sidebar "Order History", :only => :show do
    attributes_table_for customer do
      row("Total Orders") { customer.orders.count }
      row("Total Value") { number_to_currency customer.orders.sum(:total) }
    end
  end

  #sidebar "Active Admin Demo" do
  #  render('/admin/sidebar_links', :model => 'users')
  #end
end
