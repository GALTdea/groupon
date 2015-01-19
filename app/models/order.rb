class Order < ActiveRecord::Base

  belongs_to :customer
  has_many :items, :dependent => :destroy
  has_many :products, through: :items

  enum status: [ :cancelled, :submitted, :stock_up, :on_the_way, :completed ]
  enum payment: [ :cash, :alipay, :wexin, :bank ]
  enum delivery: [ :carry, :delivery ]

  validates :payment, presence: true
  validates :delivery, presence: true

  scope :submitted, -> { where("orders.status = 1") }
  scope :completed, -> { where("orders.status = 4") }
  scope :forprint,  -> { where('orders.status in (1,2,3)') }

  before_save :charge

  accepts_nested_attributes_for :items, allow_destroy: true, :reject_if => :reject_item

  def reject_item(attributes)
    exists = attributes['id'].present?
    empty = attributes[:amount].to_i <= 0
    attributes.merge!({:_destroy => 1}) if exists and empty
    return (!exists and empty)
  end

  private
    def charge
      self.total = 0
      self.items.each { |item|
        item.price = item.product.price * item.amount
        self.total += item.price
      }
    end

  def self.find_with_product(product)
    return [] unless product
    completed.includes(:items).
      where(items: { product_id: product.id }).
      order("orders.created_at DESC")
  end

end
