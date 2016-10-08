require "validators/validates_cpf_format_of"
class User < ApplicationRecord
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  has_many :locations, dependent: :destroy

  enum role: [:gympass_employee, :gym_manager, :regular_end_user]

  has_secure_password
  validates_presence_of :name
  validates_length_of :name, maximum: 100
  validates_email_format_of :email
  validates_uniqueness_of :email
  validates_presence_of :role
  validates_cpf_format_of :cpf

  before_create do |user|
    user.confirmation_token = SecureRandom.urlsafe_base64
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
