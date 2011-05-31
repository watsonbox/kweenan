class PagesController < HighVoltage::PagesController
  before_filter :logged_out_for_front_page, :only => :show
  skip_before_filter :authenticate_user!
  
  private
  
  def logged_out_for_front_page
    if params[:id] == 'front' && user_signed_in?
      redirect_to after_sign_in_path_for(current_user)
    end
  end
end