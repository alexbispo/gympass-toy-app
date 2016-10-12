class CreateGymUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :gym_users do |t|
      t.references :gym, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
