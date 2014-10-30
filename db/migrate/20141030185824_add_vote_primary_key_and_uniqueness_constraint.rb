class AddVotePrimaryKeyAndUniquenessConstraint < ActiveRecord::Migration
  def change
    add_column :votes, :id, :primary_key
    remove_index :votes, column: [:user_id]
    remove_index :votes, column: [:votable_id, :user_id]
    add_index :votes, [:user_id, :votable_id, :votable_type], unique: true
  end
end
