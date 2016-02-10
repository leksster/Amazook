class DeleteStateFromOrderAndAddAasMstate < ActiveRecord::Migration
  def change
    remove_column :orders, :state
    add_column :orders, :aasm_state, :string, :default => 'in progress'
  end
end
