class UserMailer < ActionMailer::Base
  default from: "ryan@clipcake.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sign_up.subject
  #
  def welcome(user)
    @name = user.full_name

     mail to: user.email, subject: "Send us your moolah"
  end
end
