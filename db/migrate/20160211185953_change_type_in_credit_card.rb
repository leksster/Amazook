class ChangeTypeInCreditCard < ActiveRecord::Migration
  def change
    change_column :credit_cards, :expiration_year, :string
    change_column :credit_cards, :expiration_month, :string
  end
end
