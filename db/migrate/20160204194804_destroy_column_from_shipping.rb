class DestroyColumnFromShipping < ActiveRecord::Migration
  def change
    remove_column :shippings, :order_id
  end
end
