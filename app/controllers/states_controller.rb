class StatesController < ApplicationController

  def index
    respond_to do |format|
      format.html { render "index" }
      format.json { render "cloud" }
    end
  end

  def show
    @state = State.find(params[:id])
    respond_to do |format|
      format.html { render "show" }
      format.json { render @state.cloud }
    end
  end
end
