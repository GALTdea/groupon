class ChangeQqTypeInCustomers < ActiveRecord::Migration
  def self.up
    change_column :customers, :qq, :string
  end
 
  def self.down
    change_column :customers, :qq, :integer
  end
end
