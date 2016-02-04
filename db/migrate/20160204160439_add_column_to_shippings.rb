class AddColumnToShippings < ActiveRecord::Migration
  def change
    add_column :shippings, :costs, :decimal, default: 0
  end
end
