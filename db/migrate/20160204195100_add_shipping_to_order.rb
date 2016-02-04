class AddShippingToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :shipping, index: true, foreign_key: true
  end
end
