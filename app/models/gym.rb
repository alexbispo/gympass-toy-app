class Gym < ApplicationRecord
  has_one :location, dependent: :destroy, as: :localizable
  has_many :gym_users, dependent: :destroy
  has_many :users, through: :gym_users

  acts_as_mappable through: :location

  enum status: [:pending, :approved]

  before_create do |gym|
    gym.cnpj.remove!(/\D/)
  end

  def opening_hourary
    hourary(opening_time_in_sec.to_f)
  end

  def closing_hourary
    hourary(closing_time_in_sec.to_f)
  end

  private

  def hourary(sec)
    now = Time.current
    mid_night = Time.new(now.year, now.month, now.day, 0, 0, 0)
    hourary = mid_night + sec
    hourary.to_s(:time)
  end
end
