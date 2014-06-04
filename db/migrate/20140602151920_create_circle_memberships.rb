class CreateCircleMemberships < ActiveRecord::Migration
  def change
    create_table :circle_memberships do |t|
      t.integer :circle_id, null: false
      t.integer :member_id, null: false

      t.timestamps
    end
    
    add_index :circle_memberships, :circle_id
    add_index :circle_memberships, :member_id
    add_index :circle_memberships, [:circle_id, :member_id], unique: true
  end
end
