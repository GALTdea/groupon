ActiveAdmin.register Product do

  permit_params :name, :desc, :status, :price, :image

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
    column("Image")                   {|product| image_tag(product.image.url(:thumb))}
    column :name
    column :desc
    column :status
    column :price
  end

  batch_action :update, form: {status: [['下架', 0], ['在售', 1]]} do |ids, inputs|
    Product.find(ids).each { |product| product.update(status: inputs[:status].to_i) }
    redirect_to collection_path, notice: [ids, inputs].to_s
  end



  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Edit Product" do
      f.input :name
      f.input :desc
      # f.input :image
      f.input :image, :as => :file, :hint => f.template.image_tag(f.object.image.url(:thumb))
      f.input :status, :as => :select, collection: Product.statuses.keys, :include_blank => false
      f.input :price
    end
    f.actions
  end

  # show :name => :name

  show do
    attributes_table do
      row :id
      row :name
      row :desc
      row :status do
        status_tag product.status
      end
      row :image do
        image_tag product.image.url(:medium)
      end
    end
        # :id =>        {|product| product.id}
        # column("name")       {|product| product.name}
        # column("desc")       {|product| product.desc}
        # column("Status")     {|product| status_tag(product.status)}
    active_admin_comments
  end

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
