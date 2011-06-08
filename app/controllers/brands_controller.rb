class BrandsController < ApplicationController
  skip_before_filter :require_user_data
  
  def index
    @brands = Brand.where("name like ?", "%#{params[:q]}%")
      respond_to do |format|
        format.json { render :json => @brands.map(&:attributes) }
      end
  end
end