class Login
  include ActiveModel::Model

  attr_accessor :email, :password

  validates_presence_of :email, :password
  validates_email_format_of :email
  validates_length_of :password, maximum: 8
end
