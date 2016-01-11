class OrderItem < ActiveRecord::Base
  belongs_to :order

  validates :price, :qty, presence: true
end
