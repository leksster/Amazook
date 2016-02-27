class RenameImgBook < ActiveRecord::Migration
  def change
    rename_column :books, :img, :cover
  end
end
