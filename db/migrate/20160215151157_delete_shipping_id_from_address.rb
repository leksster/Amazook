class DeleteShippingIdFromAddress < ActiveRecord::Migration
  def change
    remove_column :addresses, :user_shipping_id
    remove_column :addresses, :user_billing_id
  end
end
