class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :company
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
