class UserMailer < ActionMailer::Base
  default from: "hello@bham.al"

  def welcome_email(user)
    @user = user
    mail(to: "viveks1422@gmail.com", subject: 'Welcome to HCARE!')
  end

end
