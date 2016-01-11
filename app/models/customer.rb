class Customer < ActiveRecord::Base
  has_many :ratings
  has_many :orders
  has_many :credit_cards

  validates :firstname, :password, :lastname, :email, presence: true
  validates :email, uniqueness: true 
end
