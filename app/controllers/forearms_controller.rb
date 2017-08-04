class ForearmsController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @forearms = @workout_data.forearms
    render :index, locals: { workout_data: @workout_data, forearms: @forearms }
  end

  def show
    @forearm = Forearm.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_forearm", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, forearm: @forearm }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @forearm = Forearm.new
    render :new, locals: { workout_data: @workout_data, forearm: @forearm }
  end

  def create   
    @forearm = Forearm.new(forearm_params)

    if @forearm.save
      Event.create(user: current_user, event_type: "created_forearm", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: forearm_params })
      redirect_to workout_data_forearm_path(@workout_data_id = params[:workout_data_id], @forearm), notice: 'Forearms Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, forearm: @forearm }
    end
  end

  def edit
    @forearm = @workout_data.forearms.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, forearm: @forearm }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @forearm = Forearm.find(params[:id])

    if @forearm.update(forearm_params)
      Event.create(user: current_user, event_type: "created_forearm", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_forearms_path(@workout_data_id = params[:workout_data_id], @forearm), notice: "Forearms was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, forearm: @forearm }
    end
  end

  def destroy
    service = DestroyForearm.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Forearms was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the forearm."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def forearm_params
    new_params = params.require(:forearm).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end