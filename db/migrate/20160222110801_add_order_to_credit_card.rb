class AddOrderToCreditCard < ActiveRecord::Migration
  def change
    add_reference :credit_cards, :order, index: true, foreign_key: true
    remove_column :orders, :credit_card_id
  end
end
