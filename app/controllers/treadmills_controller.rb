class TreadmillsController < ApplicationController
  before_action :set_treadmill, only: [:show, :edit, :update, :destroy]

  def index
    @treadmills = Treadmill.all
    render :index, locals: { treadmills: @treadmills}
  end

  def show
    render :show, locals: {treadmill: @treadmill }
  end

  def new
    @treadmill = Treadmill.new
  end

  def edit
    render :edit, locals: { treadmill: @treadmill }
  end

  def create
    @treadmill = Treadmill.new(treadmill_params)

    if @treadmill.save
      redirect_to @treadmill, notice: 'Treadmills Workout data was successfully created.'
    else
      render :new, locals: { treadmill: @treadmill }
    end
  end

  def update
    if @treadmill.update(treadmill_params)
      redirect_to @treadmill, notice: 'Treadmills Workout data was successfully updated.'
    else
      render :edit, locals: { treadmill: @treadmill }
    end
  end

  def destroy
    @treadmill.destroy
    redirect_to treadmills_path, notice: 'Treadmills Workout data was successfully destroyed.'
  end

  private

  def set_treadmill
   @treadmill = Treadmill.find(params[:id])
  end

  def treadmill_params
    params.require(:treadmill).permit(:status_type, :speed, :time, :incline, :distance)
  end
end