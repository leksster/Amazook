class CreditCard < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :number, :cvv, :expiration_year, :expiration_month, :firstname, :lastname, presence: true
  validates :number, :cvv, :expiration_year, :expiration_month, numericality: true

  def name
    number
  end

  def self.months
    ('01'..'12').to_a
  end

  def self.years
    (Time.now.year..Time.now.year+20).to_a
  end
end
