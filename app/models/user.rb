class User < ApplicationRecord
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  has_many :locations, dependent: :destroy, as: :localizable
  has_many :gym_users
  has_many :gyms, through: :gym_users
  has_many :daily_tokens

  acts_as_mappable through: :locations

  enum role: [:gympass_employee, :gym_manager, :regular_end_user]

  has_secure_password
  validates_presence_of :name, :role
  validates_length_of :name, maximum: 100
  validates_email_format_of :email
  validates_uniqueness_of :email, :cpf
  validates_cpf_format_of :cpf

  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64
    user.cpf.remove!(/\D/)
  end

  def confirm!
    return if confirmed?

    self.confirmed_at = Time.current
    self.confirmation_token = ""
    save!
  end

  def confirmed?
    confirmed_at.present?
  end

end
