ActiveAdmin.register Order do

  permit_params :code, :status, :payment, :delivery, :total

  #actions :index, :show, :edit
  config.batch_actions = true

  filter :total
  filter :created_at

  scope :all, :default => true
  scope :submitted
  scope :stock_up
  scope :on_the_way
  scope :completed
  scope :cancelled

  index do
    selectable_column
    column("Order", :sortable => :id) {|order| link_to "##{order.code} ", admin_order_path(order) }
    column("State")                   {|order| status_tag(order.status) }
    column("Payment")                 {|order| status_tag(order.payment) }
    column("Delivery")                {|order| status_tag(order.delivery) }
    column("Date", :created_at)
    column("Customer", :customer, :sortable => :customer_id)
    column("Total")                   {|order| number_to_currency order.total}
    column("Comment", :comment)
    actions
  end

  batch_action :update, form: { status: [['已提交',1],['备货中',2],['送货中',3],['交易结束',4],['取消交易',0]]} do |ids, inputs|
    Order.find(ids).each { |order| order.update(status: inputs[:status].to_i) }
    redirect_to collection_path, notice: [ids, inputs].to_s
  end

  form do |f|
    f.inputs "Edit Order" do
      f.input :code
      f.input :total
      f.input :status, :as => :select, collection: Order.statuses.keys, :include_blank => false
      f.input :comment
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
