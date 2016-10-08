class Authenticate
  def self.call(email, password)
    return unless email && password
    User.confirmed.find_by_email(email.to_s)&.authenticate(password.to_s)
  end
end
