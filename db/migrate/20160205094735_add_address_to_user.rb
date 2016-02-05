class AddAddressToUser < ActiveRecord::Migration
  def change
    add_reference :users, :address, index: true, foreign_key: true
    remove_column :addresses, :order_id
  end
end
