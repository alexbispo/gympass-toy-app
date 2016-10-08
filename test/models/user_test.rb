require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "requires name" do
    user = User.create(name: "")
    refute user.errors[:name].empty?
  end

  test "requires a valid name" do
    user = User.create(name: "*"*101)
    refute user.errors[:name].empty?
  end

  test "requires email" do
    user = User.create(email: "")
    refute user.errors[:email].empty?
  end

  %w[
    invalid
    a@a
    a@a.a
    john@dispostable.com
  ].each do |email|
    test "requires valid e-mail address - #{email}" do
      user = User.create(email: email)
      refute user.errors[:email].empty?
    end
  end


  %w[
    john@somedomain.com
    john1@somedomain.com
    john.doe@somedomain.com
    john.doe1@somedomain.com
    john+spam@somedomain.com
    john@somedomain.com.br
    john@somedomain.info
    JOHN@SOMEDOMAIN.COM
    john@some-domain.com
    john@some.subdomain.com
  ].each do |email|
    test "accepts valid e-mail address - #{email}" do
      user = User.create(email: email)
      assert user.errors[:email].empty?
    end
  end

  test "requires unique e-mail" do
    existing_user = users(:john)
    user = User.create(email: existing_user.email)
    refute user.errors[:email].empty?
  end

  test "requires a cpf" do
    user = User.create(cpf: "")
    refute user.errors[:cpf].empty?
  end

  %w[
    invalid
    aaa
    00000000000
    11111111111
    12345678910
    000000000191
  ].each do |document|
    test "requires a valid cpf - #{document}" do
      user = User.create(cpf: document)
      refute user.errors[:cpf].empty?
    end
  end

  test "accepts valid cpf" do
    user = User.create(cpf: "00000000191")
    assert user.errors[:cpf].empty?
  end

  test "requires password" do
    user = User.create(password: "")
    refute user.errors[:password].empty?
  end

  test "requires password confirmation" do
    user = User.create(password: "test", password_confirmation: "invalid")
    refute user.errors[:password_confirmation].empty?
  end

  test "requires a role" do
    user = User.create(role: nil)
    refute user.errors[:role].empty?
  end
end
