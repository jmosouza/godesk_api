class AttendantMailer < ApplicationMailer

  def welcome(email, username, password, inviter_username)
    @username, @password = username, password
    email, @inviter_username = email, inviter_username
    mail to: email, subject: 'Welcome to Godesk Support Team'
  end

end
