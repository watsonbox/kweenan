class ProfilePhotosController < ApplicationController
  before_filter :require_customer
  
  def create
    if current_user.profile.photo.nil?
      current_user.profile.photo = ProfilePhoto.new(:data => params[:qqfile])
      current_user.profile.save!
      render :json => {
        :success => true,
        :html => render_to_string(
          :partial => 'photos/photos',
          :locals => {
            :photos => Array(current_user.profile.photo),
            :upload_type => :profile_photo,
            :upload_limit => 1
          }
        ).gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;')
      }, :content_type => 'text/html'
    else
      render :json => {
        :error => 'You already have a photo!' # This should never be shown to the user
      }
    end
  end
  
  def destroy
    current_user.profile.photo.destroy
    
    respond_to do |format|
      format.js do
        render :json => {
          :success => true,
          :html => render_to_string(
            :partial => 'photos/photos',
            :locals => {
              :photos => [],
              :upload_type => :profile_photo,
              :upload_limit => 1
            }
          )
        }
      end
    end
  end
end