class TricepsController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @triceps = @workout_data.triceps
    render :index, locals: { workout_data: @workout_data, triceps: @triceps }
  end

  def show
    @tricep = Tricep.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_tricep", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, tricep: @tricep }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @tricep = Tricep.new
    render :new, locals: { workout_data: @workout_data, tricep: @tricep }
  end

  def create   
    @tricep = Tricep.new(tricep_params)

    if @tricep.save
      Event.create(user: current_user, event_type: "created_tricep", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: tricep_params })
      redirect_to workout_data_tricep_path(@workout_data_id = params[:workout_data_id], @tricep), notice: 'Triceps Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, tricep: @tricep }
    end
  end

  def edit
    @tricep = Tricep.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, tricep: @tricep }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @tricep = Tricep.find(params[:id])

    if @tricep.update(tricep_params)
      Event.create(user: current_user, event_type: "created_tricep", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_triceps_path(@workout_data_id = params[:workout_data_id], @tricep), notice: "Triceps was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, tricep: @tricep }
    end
  end

  def destroy
    service = DestroyTricep.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Triceps was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the tricep."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def tricep_params
    new_params = params.require(:tricep).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end