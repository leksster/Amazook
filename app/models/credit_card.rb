class CreditCard < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  validates :number, :cvv, :expiration_year, :expiration_month, :firstname, :lastname, presence: true
  validates :number, :cvv, :expiration_year, :expiration_month, numericality: true
  validates :number, :length => { :is => 16 }
  validates :cvv, :length => { :is => 3 }


  def name
    number
  end

  def self.months
    ('01'..'12').to_a
  end

  def self.years
    (Time.now.year+1..Time.now.year+50).to_a
  end
end
