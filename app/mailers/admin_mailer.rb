class AdminMailer < ActionMailer::Base
  default from: "test@watsonbox.net"
  
  def user_signup(user)
    @user = user
    mail(:to => ADMIN_EMAIL, :subject => 'New Kweenan Signup')
  end
end