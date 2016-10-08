class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :latitude, null: false
      t.integer :longitude, null: false
      t.integer :type_of_location, null: false
      t.belongs_to :user, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
