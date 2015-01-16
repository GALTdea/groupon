class Product < ActiveRecord::Base
  has_many :items
  has_many :orders, through: :items

  scope :available, -> { where("products.status = 1") }
  scope :drafts, -> { where("products.status = 0") }

  enum status: [ :drafts, :available ]

  has_attached_file :image,
    :default_url => ':style/default.jpeg',
    :styles => { :medium => "300x300#", :thumb => "64x64#" }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

end
