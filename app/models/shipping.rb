class Shipping < ActiveRecord::Base
  has_many :orders
  validates :company, presence: true

  def name
    company
  end
end
