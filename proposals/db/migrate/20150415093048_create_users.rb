class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :user_password
      t.string :user_name
      t.string :branch_cd
      t.string :section_name
      t.string :mail
      t.string :tel
      t.string :role
      t.string :delete_flag

      t.timestamps null: false
    end
    add_index :users, :user_id
  end
end
