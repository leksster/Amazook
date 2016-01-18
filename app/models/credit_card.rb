class CreditCard < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :number, :cvv, :expiration_year, :expiration_month, :firstname, :lastname, presence: true
end
