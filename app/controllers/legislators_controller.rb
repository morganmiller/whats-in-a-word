class LegislatorsController < ApplicationController
  def show
    @user = current_user
    @legislator = Legislator.find(params[:id])
    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @legislator.cloud }
    end
  end
end
