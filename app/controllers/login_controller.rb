class LoginController < ApplicationController
  before_action :redirect_logged_user, only: %i[new create]

  def new
    @login = Login.new
  end

  def create
    @login = Login.new(login_params)
    if @login.valid?
      user = Authenticate.call(@login.email, @login.password)

      if user
        reset_session
        session[:user_id] = user.id
        session[:lat] = params[:lat].to_f
        session[:lng] = params[:lng].to_f
        redirect_to root_path
      else
        redirect_to login_path, alert: "E-mail/senha inválidos."
      end
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

  def login_params
    params.require(:login).permit(:email, :password)
  end
end
