class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :branch_cd
      t.string :user_id
      t.string :proposal_date
      t.string :section_name
      t.string :mail
      t.string :tel
      t.string :proposal_type
      t.string :project_type_a
      t.string :project_type_b
      t.string :project_type_c
      t.string :project_type_d
      t.string :project_type_e
      t.string :project_type_f
      t.text :proposal_title
      t.text :now_problem
      t.text :proposal_detail
      t.text :effect

      t.timestamps null: false
    end
    add_index :proposals, :branch_cd
    add_index :proposals, :user_id
    add_index :proposals, :proposal_date
  end
end
