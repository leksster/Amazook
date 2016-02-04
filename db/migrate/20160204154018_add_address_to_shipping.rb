class AddAddressToShipping < ActiveRecord::Migration
  def change
    add_reference :addresses, :shipping, index: true, foreign_key: true
  end
end