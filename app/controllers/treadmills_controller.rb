class TreadmillsController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @treadmills = @workout_data.treadmills
    render :index, locals: { workout_data: @workout_data, treadmills: @treadmills }
  end

  def show
    @treadmill = treadmill.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_treadmill", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, treadmill: @treadmill }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @treadmill = Treadmill.new
    render :new, locals: { workout_data: @workout_data, treadmill: @treadmill }
  end

  def create   
    @treadmill = Treadmill.new(treadmill_params)

    if @treadmill.save
      Event.create(user: current_user, event_type: "created_treadmill", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: treadmill_params })
      redirect_to workout_data_treadmill_path(@workout_data_id = params[:workout_data_id], @treadmill), notice: 'Treadmills Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, treadmill: @treadmill }
    end
  end

  def edit
    @treadmill = Treadmill.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, treadmill: @treadmill }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @treadmill = Treadmill.find(params[:id])

    if @treadmill.update(treadmill_params)
      Event.create(user: current_user, event_type: "created_treadmill", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_treadmills_path(@workout_data_id = params[:workout_data_id], @treadmill), notice: "Treadmills was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, treadmill: @treadmill }
    end
  end

  def destroy
    service = DestroyTreadmill.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Treadmills was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the treadmill."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def treadmill_params
    new_params = params.require(:treadmill).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end