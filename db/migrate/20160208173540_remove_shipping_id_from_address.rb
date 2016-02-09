class RemoveShippingIdFromAddress < ActiveRecord::Migration
  def change
    remove_column :addresses, :shipping_id
  end
end
