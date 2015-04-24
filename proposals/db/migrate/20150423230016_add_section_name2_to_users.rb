class AddSectionName2ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :section_name2, :string
  end
end
