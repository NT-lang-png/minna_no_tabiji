class CreateDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :destinations do |t|
      t.integer :itinerary_id, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.string :name, null: false
      t.string :address
      t.text :notes

      t.timestamps
    end

    add_index :destinations, :name

  end
end
