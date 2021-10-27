class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.integer :walk_id
      t.datetime :start_at
      t.datetime :end_at
      
      t.timestamps
    end
  end
end
