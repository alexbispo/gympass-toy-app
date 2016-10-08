class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 100
      t.string :email, null: false, limit: 100
      t.string :cpf, null: false, limit: 11
      t.string :password_digest, null: false
      t.integer :role, null: false
      t.datetime :confirmed_at
      t.string :confirmation_token

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
