class User < ActiveRecord::Base
  has_many :ratings
  has_many :orders
  has_many :credit_cards

  validates :firstname, :password, :lastname, :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
