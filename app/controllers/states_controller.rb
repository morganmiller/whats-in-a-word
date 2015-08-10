class StatesController < ApplicationController

  def index
  end

  def show
    @state = State.find_by(name: params[:id].upcase)
    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @state.cloud }
    end
  end
end
