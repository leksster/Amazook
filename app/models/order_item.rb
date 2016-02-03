class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  validates :price, :qty, presence: true
end
