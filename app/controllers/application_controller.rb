class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :require_user_data
  
  protected
  
  def require_customer
    redirect_to root_path unless current_user.kind_of?(Customer)
  end
  
  def require_merchant_user
    redirect_to root_path unless current_user.kind_of?(MerchantUser)
  end
  
  def require_user_data
    if signed_in?
      if current_user.kind_of?(Customer) && current_user.profile.blank?
        redirect_to new_user_profile_path
      end
    end
  end
end