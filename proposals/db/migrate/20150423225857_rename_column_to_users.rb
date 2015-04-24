class RenameColumnToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :section_name, :section_name1
  end
end
