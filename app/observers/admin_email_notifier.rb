class AdminEmailNotifier < ActiveRecord::Observer
  observe :user
  
  def after_create(user)
    AdminMailer.user_signup(user).deliver
  end
end