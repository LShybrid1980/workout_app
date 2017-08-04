class ShouldersController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @shoulders = @workout_data.shoulders
    render :index, locals: { workout_data: @workout_data, shoulders: @shoulders }
  end

  def show
    @shoulder = Shoulder.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_shoulder", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, shoulder: @shoulder }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @shoulder = Shoulder.new
    render :new, locals: { workout_data: @workout_data, shoulder: @shoulder }
  end

  def create   
    @shoulder = Shoulder.new(shoulder_params)

    if @shoulder.save
      Event.create(user: current_user, event_type: "created_shoulder", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: shoulder_params })
      redirect_to workout_data_shoulder_path(@workout_data_id = params[:workout_data_id], @shoulder), notice: 'Shoulders Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, shoulder: @shoulder }
    end
  end

  def edit
    @shoulder = Shoulder.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, shoulder: @shoulder }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @shoulder = Shoulder.find(params[:id])

    if @shoulder.update(shoulder_params)
      Event.create(user: current_user, event_type: "created_shoulder", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_shoulders_path(@workout_data_id = params[:workout_data_id], @shoulder), notice: "Shoulders was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, shoulder: @shoulder }
    end
  end

  def destroy
    service = DestroyShoulder.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Shoulders was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the shoulder."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def shoulder_params
    new_params = params.require(:shoulder).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end