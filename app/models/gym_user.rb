class GymUser < ApplicationRecord
  belongs_to :gym
  belongs_to :user
end
