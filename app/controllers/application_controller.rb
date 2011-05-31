class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :require_user_data
  
  protected
  
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.kind_of?(MerchantUser)
      edit_user_registration_path
    elsif resource_or_scope.kind_of?(Customer)
      edit_user_registration_path
    else
      super
    end
  end
  
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