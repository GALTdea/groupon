class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :customer, index: true
      t.string :area
      t.string :address

      t.timestamps
    end
  end
end
