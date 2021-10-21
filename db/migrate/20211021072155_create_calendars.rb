class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.integer :count
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
