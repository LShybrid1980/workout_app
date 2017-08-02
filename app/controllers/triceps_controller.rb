class TricepsController < ApplicationController
  before_action :set_tricep, only: [:show, :edit, :update, :destroy]

  def index
    @triceps = Tricep.all
    render :index, locals: { triceps: @triceps}
  end

  def show
    render :show, locals: {tricep: @tricep }
  end

  def new
    @tricep = Tricep.new
  end

  def edit
    render :edit, locals: { tricep: @tricep }
  end

  def create
    @tricep = Tricep.new(tricep_params)

    if @tricep.save
      redirect_to @tricep, notice: 'Triceps Workout data was successfully created.'
    else
      render :new, locals: { tricep: @tricep }
    end
  end

  def update
    if @tricep.update(tricep_params)
      redirect_to @tricep, notice: 'Triceps Workout data was successfully updated.'
    else
      render :edit, locals: { tricep: @tricep }
    end
  end

  def destroy
    @tricep.destroy
    redirect_to triceps_path, notice: 'Triceps Workout data was successfully destroyed.'
  end

  private

  def set_tricep
   @tricep = Tricep.find(params[:id])
  end

  def tricep_params
    params.require(:tricep).permit(:status_type, :weight, :set, :rep)
  end
end