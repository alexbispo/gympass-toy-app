class Gym < ApplicationRecord
  has_one :location, dependent: :destroy, as: :localizable

end
