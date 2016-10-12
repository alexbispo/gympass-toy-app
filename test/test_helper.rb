ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "capybara/rails"

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def login_as(user)
    visit login_path

    fill_in "Email", with: user.email
    fill_in "Senha", with: "test"
    click_button "Fazer login"
  end
end
