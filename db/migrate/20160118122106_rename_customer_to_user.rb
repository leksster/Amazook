class RenameCustomerToUser < ActiveRecord::Migration
  def change
    rename_table :customers, :users
  end
end
