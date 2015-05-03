class AddLockVersionToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :lock_version, :integer, :default => 0
  end
end
