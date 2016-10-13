class DailyToken < ApplicationRecord
  belongs_to :user
  belongs_to :gym

  before_create do |daily_token|
    daily_token.token = SecureRandom.urlsafe_base64
    daily_token.expires_at =  Time.current.end_of_day
  end

  def validate!
    return if validated?

    unless expired?
      self.validated_at = Time.current
      self.token = ""
    end
    save!
  end

  def validated?
    validate_at.present?
  end

  def expired?
    Time.current >= self.expires_at
  end
end
