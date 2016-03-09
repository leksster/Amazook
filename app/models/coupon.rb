class Coupon < ActiveRecord::Base
  validates :code, :discount, presence: true
  validates :discount, inclusion: 1..100
end
