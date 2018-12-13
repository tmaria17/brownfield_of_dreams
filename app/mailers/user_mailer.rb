class UserMailer < ApplicationMailer

  def registration_confirmation(user)
    @user = user

    mail(to: @user.email, subject: "Activate Turing Tutorials")
  end
end
