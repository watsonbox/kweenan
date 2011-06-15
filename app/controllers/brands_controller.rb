class BrandsController < ApplicationController
  skip_before_filter :require_user_data
  
  def index
    @brands = Brand.where("UPPER(name) like ?", "%#{params[:q].upcase}%") if params[:q].present?
    
    respond_to do |format|
      format.json { render :json => (@brands || []).map(&:attributes) }
    end
  end
end