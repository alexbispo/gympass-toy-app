class Gym < ApplicationRecord
  has_one :location, dependent: :destroy, as: :localizable
  has_many :gym_users, dependent: :destroy
  has_many :users, through: :gym_users
  has_many :daily_tokens

  acts_as_mappable through: :location

  enum status: [:pending, :approved]

  before_create do |gym|
    gym.cnpj.remove!(/\D/)
  end

  def opening_hourary
    hourary(opening_time_in_sec.to_f).to_s(:time)
  end

  def closing_hourary
    hourary(closing_time_in_sec.to_f).to_s(:time)
  end

  def closed?
    Time.use_zone("America/Sao_Paulo") do
      Time.current >= hourary(self.closing_time_in_sec.to_f)
    end
  end

  private

  def hourary(sec)
    Time.current.beginning_of_day + sec
  end
end
