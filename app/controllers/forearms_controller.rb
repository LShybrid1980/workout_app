class ForearmsController < ApplicationController
  before_action :set_forearm, only: [:show, :edit, :update, :destroy]

  def index
    @forearms = Forearm.all
    render :index, locals: { forearms: @forearms}
  end

  def show
    render :show, locals: {forearm: @forearm }
  end

  def new
    @forearm = Forearm.new
    # render :new, locals: { forearm: @forearm }
  end

  def edit
    render :edit, locals: { forearm: @forearm }
  end

  def create
    @forearm = Forearm.new(forearm_params)

    if @forearm.save
      redirect_to @forearm, notice: 'Forearms Workout data was successfully created.'
    else
      render :new, locals: { forearm: @forearm }
    end
  end

  def update
    if @forearm.update(forearm_params)
      redirect_to @forearm, notice: 'Forearms Workout data was successfully updated.'
    else
      render :edit, locals: { forearm: @forearm }
    end
  end

  def destroy
    @forearm.destroy
    redirect_to forearms_path, notice: 'Forearms Workout data was successfully destroyed.'
  end

  private

  def set_forearm
   @forearm = Forearm.find(params[:id])
  end

  def forearm_params
    params.require(:forearm).permit(:status_type, :weight, :set, :rep)
  end
end