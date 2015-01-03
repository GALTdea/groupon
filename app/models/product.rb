class Product < ActiveRecord::Base
  has_many :items
  has_many :orders, through: :items

  scope :available, -> { where("products.status = 1") }
  scope :drafts, -> { where("products.status = 0") }

  enum status: [ :drafts, :available ]
end
