class GymRegistration
  include ActiveModel::Model

  attr_accessor :name, :cnpj, :location_latitude, :location_longitude, :opening_time_hour, :opening_time_min, :closing_time_hour, :closing_time_min, :gym_managers

  validates_presence_of :name, :cnpj, :location_latitude, :location_longitude, :opening_time_hour, :opening_time_min, :closing_time_hour, :closing_time_min
  validates_cnpj_format_of :cnpj
  validate :closing_hour_should_be_grater_than_opening_hour

  def save(current_user)
    gym = Gym.new(name: name, cnpj: cnpj)
    gym.opening_time_in_sec = seconds_since_midnight(opening_time_hour, opening_time_min)
    gym.closing_time_in_sec = seconds_since_midnight(closing_time_hour, closing_time_min)
    if gym.save
      location = Location
        .new(latitude: location_latitude.to_f, longitude: location_longitude.to_f, type_of_location: Location.type_of_locations[:work])
      location.localizable = gym
      location.save!

      GymUser.create!(user: current_user, gym: gym)
      gym_managers.reject!(&:blank?)
      unless gym_managers.empty?
        gym_manager_users = User.find(gym_managers)
        gym_manager_users.each do |u|
          GymUser.create!(user: u, gym: gym)
        end
      end
    end
    gym
  end

  private

  def seconds_since_midnight(hour, min)
    now = Time.current
    "#{Time.new(now.year, now.month, now.day, hour, min, 0).seconds_since_midnight}"
  end

  def closing_hour_should_be_grater_than_opening_hour
    errors.add(:closing_time_hour, "A hora de fechamento deve ser maior do que a hora de abertura.") if closing_time_hour.to_i < opening_time_hour.to_i
  end
end
