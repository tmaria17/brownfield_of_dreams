class FriendNotifierMailer < ApplicationMailer
  def inform(user, invitee)
    mail(to: invitee, subject: "#{user.name} wants to invite you to join their app!")
  end
end
