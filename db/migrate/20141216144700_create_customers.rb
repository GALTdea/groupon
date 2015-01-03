class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :nickname
      t.string :name
      t.string :mobile
      t.integer :qq
      t.string :wxid

      t.timestamps
    end
  end
end
