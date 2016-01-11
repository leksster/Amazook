class ChangeOrderDefaultState < ActiveRecord::Migration
  def change
    change_column :orders, :state, :string, default: 'In progress'
  end
end
