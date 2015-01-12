class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :code
      t.integer :status, default: 1
      t.references :customer, index: true
      t.integer :payment
      t.integer :delivery
      t.decimal :total, precision: 5, scale: 2

      t.timestamps
    end
  end
end
