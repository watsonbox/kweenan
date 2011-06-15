class UserProfilesController < ApplicationController
  skip_before_filter :require_user_data, :only => [:new, :create]
  before_filter :require_customer
  
  def new
    redirect_to edit_user_profile_path and return if current_user.profile.present?
    @user_profile = UserProfile.new
  end
  
  def create
    @user_profile = current_user.build_profile(params[:user_profile])
    
    if @user_profile.save
      redirect_to merchants_path, :notice => t('user_profiles.saved')
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user_profile = current_user.profile
  end
  
  def update
    @user_profile = current_user.profile
    
    if @user_profile.update_attributes(params[:user_profile])
      redirect_to merchants_path, :notice => t('user_profiles.saved')
    else
      render :action => 'edit'
    end
  end
end