class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :shipping

  validates :address, :zipcode, :city, :phone, :country, presence: true
end
