class Shipping < ActiveRecord::Base
  has_many :orders
  
  has_one :address

  validates :company, presence: true

  def name
    company
  end
end
