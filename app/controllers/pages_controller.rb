class PagesController < HighVoltage::PagesController
  before_filter :logged_out_for_front_page, :only => :show
  
  private
  
  def logged_out_for_front_page
    if params[:id] == 'front' && user_signed_in?
      if current_user.is_merchant?
        redirect_to edit_user_registration_path # Normally my profile
      else
        redirect_to edit_user_registration_path # Normally find merchants
      end
    end
  end
end