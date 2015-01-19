class Customer < ActiveRecord::Base

  has_many :orders, :dependent => :destroy
  has_many :addresses, :dependent => :destroy

  accepts_nested_attributes_for :orders, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank


  validates :nickname, length: { in: 2..20 }, presence: true
  validates :name, length: { in: 2..10 }, presence: true
  validates :mobile, length: { maximum:20 }, presence: true
  validates :qq, presence: true
  validates :wxid, presence: true
end
