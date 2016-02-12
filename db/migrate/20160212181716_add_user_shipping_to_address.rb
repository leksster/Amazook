class AddUserShippingToAddress < ActiveRecord::Migration
  def change
    add_reference :addresses, :user_shipping, index: true, foreign_key: true
    add_reference :addresses, :user_billing, index: true, foreign_key: true
  end
end
