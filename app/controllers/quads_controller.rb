class QuadsController < ApplicationController
  before_action :set_quad, only: [:show, :edit, :update, :destroy]

  def index
    @quads = Quad.all
    render :index, locals: { quads: @quads}
  end

  def show
    render :show, locals: {quad: @quad }
  end

  def new
    @quad = Quad.new
  end

  def edit
    render :edit, locals: { quad: @quad }
  end

  def create
    @quad = Quad.new(quad_params)

    if @quad.save
      redirect_to @quad, notice: 'Quads Workout data was successfully created.'
    else
      render :new, locals: { quad: @quad }
    end
  end

  def update
    if @quad.update(quad_params)
      redirect_to @quad, notice: 'Quads Workout data was successfully updated.'
    else
      render :edit, locals: { quad: @quad }
    end
  end

  def destroy
    @quad.destroy
    redirect_to quads_path, notice: 'Quads Workout data was successfully destroyed.'
  end

  private

  def set_quad
   @quad = Quads.find(params[:id])
  end

  def quad_params
    params.require(:quad).permit(:status_type, :weight, :set, :rep)
  end
end