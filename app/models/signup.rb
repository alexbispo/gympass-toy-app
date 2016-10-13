class Signup
  include ActiveModel::Model
  include ActiveModel::SecurePassword

  has_secure_password

  attr_accessor :name, :email, :cpf, :role, :home_latitude, :home_longitude, :work_latitude, :work_longitude, :password_digest

  validates_presence_of :name, :email, :cpf
  validates_length_of :name, maximum: 100
  validates_email_format_of :email
  validate :email_uniqueness
  validate :cpf_uniqueness
  validates_cpf_format_of :cpf
  validates :role, presence: true , if: :is_a_regular_or_gym_manager_user?
  validates :home_latitude, presence: true, if: :is_a_regular_end_user?
  validates :home_longitude, presence: true, if: :is_a_regular_end_user?
  validates :work_latitude, presence: true, if: :is_a_regular_or_gym_manager_user?
  validates :work_longitude, presence: true, if: :is_a_regular_or_gym_manager_user?

  def save
    user = User.new(user_params)
    if user.save
      if is_a_regular_end_user?
        home_location = Location.new(home_location_params)
        home_location.localizable = user
        home_location.save!
        work_location = Location.new(work_location_params)
        work_location.localizable = user
        work_location.save!
      elsif is_a_gym_manager_user?
        work_location = Location.new(work_location_params)
        work_location.localizable = user
        work_location.save!
      elsif is_a_gympass_employee?
        gympass_location = Location.new(gympass_location_params)
        gympass_location.localizable = user
        gympass_location.save!
      end
    end
    user
  end


  private

  def gympass_location_params
    {
      latitude: "-23.5693838",
      longitude: "-46.6920896",
      type_of_location: Location.type_of_locations[:work]
    }
  end

  def home_location_params
    {
      latitude: self.home_latitude.to_f,
      longitude: self.home_longitude.to_f,
      type_of_location: Location.type_of_locations[:home]
    }
  end

  def work_location_params
    {
      latitude: self.work_latitude.to_f,
      longitude: self.work_longitude.to_f,
      type_of_location: Location.type_of_locations[:work]
    }
  end

  def user_params
    {
      name: self.name,
      email: self.email,
      cpf: self.cpf,
      role: self.role.to_i,
      password: self.password,
      password_confirmation: self.password_confirmation
    }
  end

  def email_uniqueness
    errors.add(:email, "E-mail já cadastrado") if User.find_by_email(self.email)
  end

  def cpf_uniqueness
    errors.add(:cpf, "CPF já cadastrado") if User.find_by_cpf(self.cpf)
  end

  def is_a_regular_or_gym_manager_user?
    not is_a_gympass_employee?
  end

  def is_a_regular_end_user?
    # binding.pry
    self.role.to_i == 2
  end

  def is_a_gym_manager_user?
    self.role.to_i == 1
  end

  def is_a_gympass_employee?
    self.email.ends_with?("@gympass.com")
  end
end
