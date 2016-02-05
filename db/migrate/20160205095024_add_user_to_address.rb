class AddUserToAddress < ActiveRecord::Migration
  def change
    add_reference :addresses, :user, index: true, foreign_key: true
    remove_column :users, :address_id
  end
end
