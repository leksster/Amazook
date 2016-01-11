class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :credit_card
  has_many :order_items
  has_one :address

  validates :total_price, :completed_date, :state, presence: true
  validates :total_price, numericality: true
end
