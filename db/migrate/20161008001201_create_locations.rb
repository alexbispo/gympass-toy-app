class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.integer :type_of_location, null: false
      t.belongs_to :user, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
