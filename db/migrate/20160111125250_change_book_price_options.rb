class ChangeBookPriceOptions < ActiveRecord::Migration
  def change
    change_column :books, :price, :decimal, precision: 10, scale: 2
  end
end
