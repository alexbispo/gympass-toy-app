class SignupController < ApplicationController
  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(signup_params)

    if @signup.valid?
      if @signup.save
        redirect_to root_path, notice: "E-mail de confirmação enviado!"
      end
    else
      render :new
    end
  end

  private

  def signup_params
    params.require(:signup)
      .permit(:name, :email, :cpf, :password, :password_confirmation, :role, :home_latitude, :home_longitude, :work_latitude, :work_longitude)
  end
end
