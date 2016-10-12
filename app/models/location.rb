class Location < ApplicationRecord
  belongs_to :localizable, polymorphic: true

  enum type_of_location: [:home, :work]
end
