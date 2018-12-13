class GithubMailer < ApplicationMailer

  def invite(invitee, current_user)
    @invitee = invitee
    @user = current_user
    # binding.pry
    mail(to: @invitee[:email], subject: "Invitation to Turing Tutorials")
  end
end
