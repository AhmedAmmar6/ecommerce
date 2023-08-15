class RenameBodyToContent < ActiveRecord::Migration[7.0]
  def change
    rename_column :stores, :type, :category
  end
end
