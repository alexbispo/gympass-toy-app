class CreateDailyTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_tokens do |t|
      t.string :token, null: false
      t.datetime :validate_at
      t.datetime :expires_at, null: false
      t.belongs_to :user, foreign_key: true, index: true, null: false
      t.belongs_to :gym, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
