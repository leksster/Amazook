class AddImgToBook < ActiveRecord::Migration
  def change
    add_column :books, :img, :string, :default => '/assets/cover.jpg'
  end
end
