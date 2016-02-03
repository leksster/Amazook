class Book < ActiveRecord::Base
  belongs_to :category
  belongs_to :author
  has_many :ratings, dependent: :destroy

  validates :title, :price, :qty, presence: true
  validates :price, :qty, numericality: true

end
