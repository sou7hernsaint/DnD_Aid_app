class Api::AlignmentsController < ApplicationController
  def index
    # render json: "message: Chaotic Evil is bad"
    @alignments = Alignment.all
    render "index.json.jb"
  end

  def show
    @alignment = Alignment.find_by(id: params[:id])
    render "show.json.jb"
  end
end
