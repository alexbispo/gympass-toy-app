class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      redirect_to root_path, notice: "E-mail de confirmação enviado!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(:name, :email, :cpf, :password, :password_confirmation)
  end
end
