class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :upvotes
      t.integer :downvotes
      t.references :parent, polymorphic: true, index: true
      t.references :user, index: true
      t.text :content

      t.timestamps
    end
  end
end
