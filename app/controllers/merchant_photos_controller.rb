class MerchantPhotosController < ApplicationController
  before_filter :require_merchant_user
  
  def create
    if current_user.merchant.photos.count < 6
      current_user.merchant.photos << MerchantPhoto.new(:data => params[:qqfile])
      current_user.merchant.save!
      render :json => {
        :success => true,
        :html => render_to_string(
          :partial => 'photos/photos',
          :locals => { :photos => current_user.merchant.photos, :upload_type => :merchant_photo }
        ).gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;')
      }, :content_type => 'text/html'
    else
      render :json => {
        :error => 'Too many photos!' # This should never be shown to the user
      }
    end
  end
  
  def destroy
    current_user.merchant.photos.find(params[:id]).destroy
    
    respond_to do |format|
      format.js do
        render :json => {
          :success => true,
          :html => render_to_string(:partial => 'photos/photos', :locals => { :photos => current_user.merchant.photos, :upload_type => :merchant_photo })
        }
      end
    end
  end
end