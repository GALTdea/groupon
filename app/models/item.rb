class Item < ActiveRecord::Base
  #has_one :product
  belongs_to :order
  belongs_to :product

  validates :amount, numericality: { greater_than: 0 }, presence: true
  validates :product_id, presence: true
end
