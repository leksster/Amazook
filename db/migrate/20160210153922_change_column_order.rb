class ChangeColumnOrder < ActiveRecord::Migration
  def change
    change_column :orders, :aasm_state, :string, :default => nil
  end
end
