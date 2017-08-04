class CalvesController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @calves = @workout_data.calves
    render :index, locals: { workout_data: @workout_data, calves: @calves }
  end

  def show
    @calf = Calf.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_calf", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, calf: @calf }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @calf = Calf.new
    render :new, locals: { workout_data: @workout_data, calf: @calf }
  end

  def create   
    @calf = Calf.new(calf_params)

    if @calf.save
      Event.create(user: current_user, event_type: "created_calf", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: calf_params })
      redirect_to workout_data_calf_path(@workout_data_id = params[:workout_data_id], @calf), notice: 'Calves Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, calf: @calf }
    end
  end

  def edit
    @calf = Calf.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, calf: @calf }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @calf = Calf.find(params[:id])

    if @calf.update(calf_params)
      Event.create(user: current_user, event_type: "created_calf", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_calfs_path(@workout_data_id = params[:workout_data_id], @calf), notice: "Calves was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, calf: @calf }
    end
  end

  def destroy
    service = DestroyCalf.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Calves was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the calf."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def calf_params
    new_params = params.require(:calf).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end