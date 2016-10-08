class Location < ApplicationRecord
  belongs_to :user

  enum type_of_location: [:home, :work]
end
