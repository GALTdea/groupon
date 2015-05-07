class ChangeTotalTypeInOrders < ActiveRecord::Migration
  def change
    change_column :orders, :total, :decimal
  end
end
