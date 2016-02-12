class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :credit_card
  belongs_to :shipping
  has_one :address
  belongs_to :shipping
  has_many :order_items, dependent: :destroy

  validates :total_price, :completed_date, :aasm_state, presence: true
  validates :total_price, numericality: true  

  aasm do
    state :in_progress, :initial => true
    state :completed
    state :shipped

    event :complete do
      transitions :from => :in_progress, :to => :completed
    end
  end

  def subtotal
    order_items.inject(0) { |n, order_item| n += order_item.price * order_item.qty }
  end

  def aasm_state_enum
    ['in_progress', 'completed', 'shipped']
  end

end
