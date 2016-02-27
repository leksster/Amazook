class Edit < ActiveRecord::Migration
  def change
    change_column_default :books, :cover, nil
  end
end
