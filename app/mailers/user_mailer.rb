class UserMailer < ApplicationMailer
  default from: "no-reply@amik.com"

  def welcome_email
    @user = params[:user]
    @url = "http://localhost:3000/users/sign_in"
    mail(to: @user.email, subject: "Thank you for joining Amik!")
  end
end
