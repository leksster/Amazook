class ChangeTotalPriceOptions < ActiveRecord::Migration
  def change
    change_column :orders, :total_price, :decimal, precision: 10, scale: 2
  end
end
