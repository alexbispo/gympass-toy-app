require "test_helper"

class LoginTest < ActionDispatch::IntegrationTest
  test "with valid credentials" do
    user = users(:john)

    login_as(user)

    assert_equal root_path, current_path
    assert page.has_selector?("li.current-user-name")
  end

  test "with absent user" do
    visit login_path

    fill_in "Email", with: "absent@mysite.com"
    fill_in "Senha", with: "test"
    click_button "Fazer login"

    assert_equal login_path, current_path
    assert page.has_text?("E-mail/senha inválidos.")
  end

  test "with no confirmed user" do
    user = users(:no_confirmed_user)
    visit login_path

    login_as(user)

    assert_equal login_path, current_path
    assert page.has_text?("E-mail/senha inválidos.")
  end
end
