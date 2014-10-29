class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :upvotes
      t.integer :downvotes
      t.string :title
      t.references :user, index: true
      t.text :self_text
      t.string :link
      t.boolean :is_self_post

      t.timestamps
    end
  end
end
