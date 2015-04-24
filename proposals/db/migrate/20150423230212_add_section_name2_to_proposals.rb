class AddSectionName2ToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :section_name2, :string
  end
end
