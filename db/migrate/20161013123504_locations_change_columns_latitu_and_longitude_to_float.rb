class LocationsChangeColumnsLatituAndLongitudeToFloat < ActiveRecord::Migration[5.0]
  def up
    old_locations = Location.all.inject({}) do |memo, loc|
      memo[loc.id] = [loc.latitude.to_f, loc.longitude.to_f];
      loc.save
      memo
    end

    binding.pry
    remove_column :locations, :latitude
    remove_column :locations, :longitude

    Location.reset_column_information

    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float

    Location.reset_column_information

    old_locations.each do |id, loc|
      puts "updating location #{id}"
      Location.find(id).update_attributes(latitude: loc.first, longitude: loc.second)
    end
  end

  def down
    remove_column :locations, :latitude
    remove_column :locations, :longitude
    Location.reset_column_information
    add_column :locations, :latitude, :string, null: false
    add_column :locations, :longitude, :string, null: false
  end
end
