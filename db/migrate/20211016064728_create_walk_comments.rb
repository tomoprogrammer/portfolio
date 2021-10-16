class CreateWalkComments < ActiveRecord::Migration[5.2]
  def change
    create_table :walk_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :walk_id

      t.timestamps
    end
  end
end
