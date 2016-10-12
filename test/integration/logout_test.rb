require "test_helper"

class LogoutTest < ActionDispatch::IntegrationTest
  test "terminates session" do
    user = users(:john)
    login_as(user)

    click_button "Sair"

    assert_equal login_path, current_path
    refute page.has_selector?("li.current-user-name")
  end
end
