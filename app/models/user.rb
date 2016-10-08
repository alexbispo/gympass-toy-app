require "validators/validates_cpf_format_of"
class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name
  validates_length_of :name, maximum: 100
  validates_email_format_of :email
  validates_uniqueness_of :email
  validates_presence_of :role
  validates_numericality_of :role, only_integer: true
  validates_cpf_format_of :cpf
end
