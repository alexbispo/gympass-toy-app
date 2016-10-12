require "test_helper"
require "cpf_cnpj"

class SignupTest < ActionDispatch::IntegrationTest
  test "with an email ending with @gympass.com" do
    visit signup_path

    fill_in "Nome e sobrenome" , with: "Jane Doe"
    fill_in "Email para cadastro", with: "janedoe@gympass.com"
    fill_in "CPF", with: CPF.generate
    fill_in "Crie sua senha", with: "janeDoeSecret123"
    fill_in "Confirme sua senha", with: "janeDoeSecret123"

    click_button "Cadastrar"
    user = User.find_by_email("janedoe@gympass.com")
    # binding.pry
    assert_equal "gympass_employee", user.role
    assert user.locations.any? { |l| l.type_of_location == "work" }
  end

  test "as a gym manager" do
    visit signup_path

    fill_in "Nome e sobrenome" , with: "João Doe"
    fill_in "Email para cadastro", with: "joaodoe@mysite.com"
    fill_in "CPF", with: CPF.generate
    fill_in "Crie sua senha", with: "joaoDoeSecret123"
    fill_in "Confirme sua senha", with: "joaoDoeSecret123"
    choose("Gerente de academia")
    fill_in id: "signup_work_latitude", with: "-23.570787"
    fill_in id: "signup_work_longitude", with: "-46.6915844"

    click_button "Cadastrar"
    user = User.find_by_email("joaodoe@mysite.com")
    # binding.pry
    assert_equal "gym_manager", user.role
    assert user.locations.any? { |l| l.type_of_location == "work" }
  end

  test "as a regular end user" do
    visit signup_path
    fill_in "Nome e sobrenome" , with: "Marcos Doe"
    fill_in "Email para cadastro", with: "marcosdoe@mysite.com"
    fill_in "CPF", with: CPF.generate
    fill_in "Crie sua senha", with: "marcosDoeSecret123"
    fill_in "Confirme sua senha", with: "marcosDoeSecret123"
    choose("Usuário de academia")
    fill_in id: "signup_home_latitude", with: "-23.570787"
    fill_in id: "signup_home_longitude", with: "-46.6915844"
    fill_in id: "signup_work_latitude", with: "-23.570787"
    fill_in id: "signup_work_longitude", with: "-46.6915844"

    click_button "Cadastrar"
    user = User.find_by_email("marcosdoe@mysite.com")
    assert_equal "regular_end_user", user.role
    assert user.locations.any? { |l| l.type_of_location == "home" }
    assert user.locations.any? { |l| l.type_of_location == "work" }
  end

  test "requires a unique email" do
    existing_user = users(:john)
    visit signup_path

    fill_in "Nome e sobrenome" , with: "Fernando Doe"
    fill_in "Email para cadastro", with: existing_user.email
    fill_in "CPF", with: CPF.generate
    fill_in "Crie sua senha", with: "fernandoDoeSecret123"
    fill_in "Confirme sua senha", with: "fernandoDoeSecret123"

    click_button "Cadastrar"

    assert_equal signup_path, current_path
    assert page.has_text?("E-mail já cadastrado")
  end

  test "requires a unique cpf" do
    existing_user = users(:john)
    visit signup_path

    fill_in "Nome e sobrenome" , with: "Fernanda Doe"
    fill_in "Email para cadastro", with: "fernandadoe@mysite.com"
    fill_in "CPF", with: existing_user.cpf
    fill_in "Crie sua senha", with: "fernandaDoeSecret123"
    fill_in "Confirme sua senha", with: "fernandaDoeSecret123"

    click_button "Cadastrar"

    assert_equal signup_path, current_path
    assert page.has_text?("CPF já cadastrado")
  end
end
