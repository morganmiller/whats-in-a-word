class StatesController < ApplicationController

  def show
    @state = State.find(params[:id])
    gon.words = @state.words.map(&:word)
    render json: gon.words

    gon.jbuilder :template => "app/views/tags/cloud.json.jbuilder", as: "tags"
  end

  def cloud

  end
end
