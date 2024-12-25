class AddGeocodingColumnToDestination < ActiveRecord::Migration[6.1]
  def change
    add_column :destinations, :latitude, :float, null: false, default: 0
    add_column :destinations, :longitude, :float, null: false, default: 0
  end
end
