class PagesController < HighVoltage::PagesController
  before_filter :logged_out_for_front_page, :only => :show
  skip_before_filter :authenticate_user!
  
  private
  
  def logged_out_for_front_page
    if params[:id] == 'front' && user_signed_in?
      if current_user.kind_of?(MerchantUser)
        redirect_to edit_user_registration_path # Normally my profile
      else
        redirect_to edit_user_registration_path # Normally find merchants
      end
    end
  end
end