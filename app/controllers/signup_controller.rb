class SignupController < ApplicationController
  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(signup_params)

    if @signup.valid?
      User.transaction do
        user = @signup.save
        if user.persisted?
          SignupMailer.confirm_email(user).deliver_now
          redirect_to root_path, notice: "E-mail de confirmação enviado!"
        end
      end
    else
      if @signup.errors.has_key?(:role)
        flash[:alert] = "Por favor informe se você é um Gerente de academia ou Usuário de academia."
      end
      render :new
    end
  end

  private

  def signup_params
    params.require(:signup)
      .permit(:name, :email, :cpf, :password, :password_confirmation, :role, :home_latitude, :home_longitude, :work_latitude, :work_longitude)
  end
end
