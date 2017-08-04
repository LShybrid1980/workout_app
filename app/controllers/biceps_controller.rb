class BicepsController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @biceps = @workout_data.biceps
    render :index, locals: { workout_data: @workout_data, biceps: @biceps }
  end

  def show
    @bicep = Bicep.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_bicep", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, bicep: @bicep }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @bicep = Bicep.new
    render :new, locals: { workout_data: @workout_data, bicep: @bicep }
  end

  def create   
    @bicep = Bicep.new(bicep_params)

    if @bicep.save
      Event.create(user: current_user, event_type: "created_bicep", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: bicep_params })
      redirect_to workout_data_bicep_path(@workout_data_id = params[:workout_data_id], @bicep), notice: 'Biceps Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, bicep: @bicep }
    end
  end

  def edit
    @bicep = Bicep.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, bicep: @bicep }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @bicep = Bicep.find(params[:id])

    if @bicep.update(bicep_params)
      Event.create(user: current_user, event_type: "created_bicep", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_biceps_path(@workout_data_id = params[:workout_data_id], @bicep), notice: "Biceps was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, bicep: @bicep }
    end
  end

  def destroy
    service = DestroyBicep.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Biceps was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the bicep."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def bicep_params
    new_params = params.require(:bicep).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end