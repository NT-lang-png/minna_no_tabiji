class CreateItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :itineraries do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :region, null: false
      t.integer :day_number, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps null: false
    end

    add_index :itineraries, :title
    add_index :itineraries, :region

  end
end
