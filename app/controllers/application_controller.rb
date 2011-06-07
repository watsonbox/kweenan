class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :production_password, :authenticate_user!, :require_user_data
  
  protected
  
  def after_sign_in_path_for(user)
    if user.kind_of?(MerchantUser)
      user.merchant.blank? ? new_merchant_profile_path : merchant_profile_path
    elsif user.kind_of?(Customer)
      user.profile.blank? ? new_user_profile_path : merchants_path
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
    if signed_in? && ![destroy_user_session_path, new_user_session_path].include?(request.fullpath)
      if current_user.kind_of?(Customer) && current_user.profile.blank?
        flash[:alert] = t('user_profiles.data_required')
        redirect_to new_user_profile_path
      elsif current_user.kind_of?(MerchantUser) && current_user.merchant.blank?
        flash[:alert] = t('merchants.data_required')
        redirect_to new_merchant_profile_path
      end
    end
  end
  
  def production_password
    if Rails.env == 'production'
      authenticate_or_request_with_http_basic do |username, password|
        username == PRODUCTION_USER && password == PRODUCTION_PASSWORD
      end
    end
  end
end