class ConfirmationController < ApplicationController

  def show
    user = User.find_by(confirmation_token: params[:token])
    if user.present?
      user.confirm!
      redirect_to root_path, notice: "Cadastro confirmado com sucesso!"
    else
      redirect_to signup_path
    end
  end
end
