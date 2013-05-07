class UserMailer < ActionMailer::Base
  default from: "cmu.is.272@gmail.com"

  # user is an actual USER OBJECT
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Forgotten password"
  end
end
