class Book < ActiveRecord::Base
  mount_uploader :cover, CoverUploader
  belongs_to :category
  belongs_to :author
  has_many :ratings, dependent: :destroy
  has_many :order_items

  validates :title, :price, :qty, presence: true
  validates :price, :qty, numericality: true

  def not_reviewed_by?(user)
    self.ratings.where(:user => user).empty?
  end

  scope :bestsellers, -> (count) { Book.joins(:order_items).group(:id).order('SUM(order_items.qty) DESC') }
end
