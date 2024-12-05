class CreateFavotites < ActiveRecord::Migration[6.1]
  def change
    create_table :favotites do |t|
      t.integer :user_id, null: false
      t.integer :itinerary_id, null: false

      t.timestamps
    end
  end
end
