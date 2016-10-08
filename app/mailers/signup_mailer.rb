class SignupMailer < ApplicationMailer

  def confirm_email(user)
    @user = user
    @confirmation_link = confirmation_url({
        token: @user.confirmation_token
    })

    mail({
      to: @user.email,
      bcc: ["sign ups <signups@gympasstoy.net>"],
      subject: "Confirmação de cadastro"
    })
  end
end
