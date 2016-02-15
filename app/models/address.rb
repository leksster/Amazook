class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  validates :firstname, :lastname, :address, :zipcode, :city, :phone, :country, presence: true
end
