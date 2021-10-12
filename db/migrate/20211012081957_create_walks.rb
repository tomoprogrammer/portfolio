class CreateWalks < ActiveRecord::Migration[5.2]
  def change
    create_table :walks do |t|
      t.integer :user_id
      t.integer :walk_count
      t.string :memo
      t.string :walk_image_id

      t.timestamps
    end
  end
end
