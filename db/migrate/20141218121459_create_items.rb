class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :order, index: true
      t.references :product, index: true
      t.integer :amount, default: 0
      t.decimal :price, default: 0

      t.timestamps
    end
  end
end
