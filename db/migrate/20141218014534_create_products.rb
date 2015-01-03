class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :desc
      t.string :image
      t.integer :status, default: 1
      t.decimal :price, precision: 5, scale: 2

      t.timestamps
    end
  end
end
