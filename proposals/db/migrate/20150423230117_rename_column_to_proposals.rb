class RenameColumnToProposals < ActiveRecord::Migration
  def change
    rename_column :proposals, :section_name, :section_name1
  end
end
