ActiveAdmin.register Product do

  permit_params :name, :desc, :status, :price

  scope :all, :default => true

  scope :available do |products|
    products.where("status = 1")
    # products.where("available_on < ?", Date.today)
  end
  scope :drafts do |products|
    products.where("status = 0")
  end
  # scope :featured_products do |products|
  #   products.where(:featured => true)
  # end

  #index :as => :grid do |product|
  #  div do
  #    a :href => admin_product_path(product) do
  #      image_tag("assets/" + product.image)
  #    end
  #  end
  #  a truncate(product.name), :href => admin_product_path(product)
  #end

  index do
    selectable_column
    id_column
    column :name
    column :desc
    column :status
    column :price
  end

  form do |f|
    f.inputs "Edit Product" do
      f.input :name
      f.input :desc
      f.input :image
      f.input :status, :as => :select, collection: Product.statuses.keys, :include_blank => false
      f.input :price
    end
    f.actions
  end

  show :name => :name

  sidebar :product_stats, :only => :show do
    attributes_table_for resource do
      row("Total Sold")  { Order.find_with_product(resource).count }
      row("Dollar Value"){ number_to_currency Item.where(:product_id => resource.id).sum(:price) }
    end
  end

  sidebar :recent_orders, :only => :show do
    Order.find_with_product(resource).limit(5).collect do |order|
      auto_link(order)
    end.join(content_tag("br")).html_safe
  end

end
