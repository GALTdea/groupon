ActiveAdmin.register Address do

  permit_params :id, :area, :address

  config.batch_actions = true

  filter :area
  filter :created_at

  index do
    selectable_column
    id_column
    column :area
    column :address
    column :created_at
    actions
  end

  #sidebar "Active Admin Demo" do
  #  render('/admin/sidebar_links', :model => 'users')
  #end
end

