class WorkoutDatasController < ApplicationController
  before_action :set_workout_data, only: [:show, :edit, :update, :destroy]

  def index
    @workout_datas = WorkoutData.all
    render :index, locals: { workout_datas: @workout_datas}
  end

  def show
    render :show, locals: {workout_data: @workout_data }
  end

  def new
    @workout_data = WorkoutData.new
  end

  def edit
    render :edit, locals: { workout_data: @workout_data }
  end

  def create
    @workout_data = WorkoutData.new(workout_data_params)
    @workout_data.user = current_user

    if @workout_data.save
      redirect_to workout_data_path(@workout_data), notice: 'Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data }
    end
  end

  def update
    if @workout_data.update(workout_data_params)
      redirect_to @workout_data, notice: 'Workout data was successfully updated.'
    else
      render :edit, locals: { workout_data: @workout_data }
    end
  end

  def destroy
    @workout_data.destroy
    redirect_to workout_datas_path, notice: 'Workout data was successfully destroyed.'
  end

  private

  def set_workout_data
   @workout_data = WorkoutData.find(params[:id])
  end

  def workout_data_params  
    params.require(:workout_data).permit(:date)
  end
end