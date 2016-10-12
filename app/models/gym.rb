class Gym < ApplicationRecord
  has_one :location, dependent: :destroy, as: :localizable
  has_many :gym_users
  has_many :users, through: :gym_users

end
