class AddNullConstraintAndDefaultToAddressInDestinations < ActiveRecord::Migration[6.1]
  def change
    change_column :destinations, :address, :string, null: false, default: ""
  end
end
