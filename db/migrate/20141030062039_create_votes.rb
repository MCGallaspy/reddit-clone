class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes, id: false do |t|
      t.boolean :is_upvote
      t.string :votable_type
      t.integer :votable_id
      t.references :user

      t.timestamps
    end
    add_index :votes, [:votable_id, :user_id]
    add_index :votes, :user_id
  end
end
