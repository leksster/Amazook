class Changes < ActiveRecord::Migration
  def change
    change_column :books, :img, :string, :default => "cover.jpg"
  end
end
