require "test_helper"
require "cpf_cnpj"

class GymRegistrationTest < ActionDispatch::IntegrationTest
  test "just current user as gym manager" do
    current_user = users(:john)
    login_as(current_user)
    visit new_gym_path

    cnpj = CNPJ.generate

    fill_in "Nome Fantasia", with: "Academia Teste 1"
    fill_in "CNPJ", with: cnpj
    fill_in "Hora de abertura", with: 8
    fill_in "Minuto de abertura", with: 0
    fill_in "Hora de fechamento", with: 23
    fill_in "Minuto de fechamento", with: 0
    fill_in "Endereço latitude", with: "-23.5716939"
    fill_in "Endereço longitude", with: "-46.7086971"

    click_button "Cadastrar"

    gym = Gym.find_by_cnpj(cnpj)

    assert_equal root_path, current_path
    assert gym.pending?
    assert gym.location.work?
    assert_equal current_user.email, gym.users.first.email
    assert page.has_text?("Academia cadastrada com sucesso. Aguardando aprovação!")
  end

  test "requires closing time be greater than opening time" do
    current_user = users(:john)
    login_as(current_user)
    visit new_gym_path

    cnpj = CNPJ.generate

    fill_in "Nome Fantasia", with: "Academia Teste 1"
    fill_in "CNPJ", with: cnpj
    fill_in "Hora de abertura", with: 23
    fill_in "Minuto de abertura", with: 0
    fill_in "Hora de fechamento", with: 8
    fill_in "Minuto de fechamento", with: 0
    fill_in "Endereço latitude", with: "-23.5716939"
    fill_in "Endereço longitude", with: "-46.7086971"

    click_button "Cadastrar"

    assert_equal gyms_path, current_path
    assert page.has_text?("A hora de fechamento deve ser maior do que a hora de abertura.")
  end
end
