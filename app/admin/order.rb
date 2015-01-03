ActiveAdmin.register Order do

  permit_params :code, :status, :total

  #actions :index, :show, :edit

  filter :total
  filter :created_at

  scope :all, :default => true
  scope :in_progress
  scope :completed
  scope :cancelled
  scope :invoiced

  index do
    column("Order", :sortable => :id) {|order| link_to "##{order.code} ", admin_order_path(order) }
    column("State")                   {|order| status_tag(order.status) }
    column("Date", :created_at)
    column("Customer", :customer, :sortable => :customer_id)
    column("Total")                   {|order| number_to_currency order.total}
    actions
  end

  form do |f|
    f.inputs "Edit Order" do
      f.input :code
      f.input :total
      f.input :status, :as => :select, collection: Order.statuses.keys, :include_blank => false
    end
    f.actions
  end

  show do
    panel "Invoice" do
      table_for(order.items) do |t|
        t.column("Product") {|item| auto_link item.product}
        t.column("Descripton") {|item| item.product.desc}
        t.column("Amount") {|item| item.amount}
        t.column("Price") {|item| number_to_currency item.product.price}

        tr :class => "odd" do
          td ""
          td ""
          td "Total:", :style => "text-align: right;"
          td number_to_currency(order.total)
        end
      end
    end

    active_admin_comments
  end

  sidebar :customer_information, :only => :show do
    attributes_table_for order.customer do
      row("User") { auto_link order.customer }
      row :mobile
      row :qq
    end
  end

end
