class CreateGyms < ActiveRecord::Migration[5.0]
  def change
    create_table :gyms do |t|
      t.string :name, null: false, limit: 100
      t.string :cnpj, null: false, limit: 14
      t.string :opening_time_in_sec, null: false
      t.string :closing_time_in_sec, null: false

      t.timestamps
    end

    add_index :gyms, :cnpj, unique: true
  end
end
