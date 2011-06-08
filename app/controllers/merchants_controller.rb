class MerchantsController < ApplicationController
  skip_before_filter :require_user_data, :only => [:new, :create]
  before_filter :require_merchant_user, :only => [:new, :create, :edit, :update]
  
  def index
    @merchants = Merchant.limit(10).page params[:page]
  end
  
  def show
    if params[:id].present?
      @merchant = Merchant.find(params[:id])
    else
      redirect_to root_path and return unless current_user.kind_of?(MerchantUser)
      @merchant = current_user.merchant
    end
  end
  
  def new
    @merchant = Merchant.new
  end
  
  def create
    @merchant = current_user.merchant || Merchant.new
    @merchant.attributes = params[:merchant]
    
    if @merchant.save
      current_user.update_attributes(:merchant => @merchant)
      flash[:notice] = t('merchants.saved')
      redirect_to merchant_profile_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @merchant = current_user.merchant
  end
  
  def update
    @merchant = current_user.merchant
    
    if @merchant.update_attributes(params[:merchant])
      flash[:notice] = t('merchants.saved')
      redirect_to merchant_profile_path
    else
      render :action => 'edit'
    end
  end
  
  protected
  
  helper_method :this_is_my_merchant_profile
  def this_is_my_merchant_profile
    current_user.merchant.present? && [merchant_profile_path, merchant_path(current_user.merchant)].include?(request.fullpath)
  end
end