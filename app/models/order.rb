class Order < ActiveRecord::Base
  include AASM
  belongs_to :user

  belongs_to :shipping
  
  has_many :order_items, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_one :billing_address, dependent: :destroy
  has_one :shipping_address, dependent: :destroy

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :credit_card
  

  validates :total_price, :completed_date, :aasm_state, presence: true
  validates :total_price, numericality: true  

  aasm do
    state :in_progress, :initial => true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :queued do
      transitions :from => :in_progress, :to => :in_queue
    end
  end

  ['billing_address', 'shipping_address', 'credit_card'].each do |method|
    define_method("build_or_find_#{method}") do |user|
      return instance_eval(method) unless self.instance_eval(method).nil?
      return instance_eval("build_#{method}(user.instance_eval(method).attributes.except('id', 'user_id'))") unless user.instance_eval(method).nil?
      return instance_eval("build_#{method}") if self.instance_eval(method).nil? && user.instance_eval(method).nil?
    end
  end

  rails_admin do
    edit do
      include_all_fields
    end
    list do
      field :id
      field :aasm_state
      field :total_price
      include_all_fields
    end
  end

  def subtotal
    order_items.inject(0) { |n, order_item| n += order_item.price * order_item.qty }
  end

  def aasm_state_enum
    self.class.aasm.states_for_select
  end
end
