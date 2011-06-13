class PhotosController < ApplicationController
  before_filter :require_merchant_user
  
  def create
    if current_user.merchant.photos.count < 6
      current_user.merchant.photos.create!(:data => env['rack.request.form_hash']['file'][:tempfile], :data_file_name => params[:qqfile])
      render :json => {
        :success => true,
        :html => render_to_string(:partial => 'photos', :locals => { :photos => current_user.merchant.photos, :uploadable => true })
      }
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
          :html => render_to_string(:partial => 'photos', :locals => { :photos => current_user.merchant.photos, :uploadable => true })
        }
      end
    end
  end
end