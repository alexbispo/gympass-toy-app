class DailyToken < ApplicationRecord
  belongs_to :user
  belongs_to :gym

  before_create do |daily_token|
    daily_token.token = SecureRandom.urlsafe_base64
    daily_token.expires_at =  Time.current.end_of_day
  end

  def validate!
    return if validated? or expired?
    Time.use_zone("America/Sao_Paulo") do
      self.validate_at = Time.current
    end
    self.token = ""
    save!
  end

  def validated?
    validate_at.present?
  end

  def expired?
    Time.use_zone("America/Sao_Paulo") do
      Time.current >= self.expires_at
    end
  end
end
