class UpperBacksController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @upper_backs = @workout_data.upper_backs
    render :index, locals: { workout_data: @workout_data, upper_backs: @upper_backs }
  end

  def show
    @upper_back = UpperBack.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_upper_back", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, upper_back: @upper_back }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @upper_back = UpperBack.new
    render :new, locals: { workout_data: @workout_data, upper_back: @upper_back }
  end

  def create   
    @upper_back = UpperBack.new(upper_back_params)

    if @upper_back.save
      Event.create(user: current_user, event_type: "created_upper_back", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: upper_back_params })
      redirect_to workout_data_upper_back_path(@workout_data_id = params[:workout_data_id], @upper_back), notice: 'Upper Back Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, upper_back: @upper_back }
    end
  end

  def edit
    @upper_back = UpperBack.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, upper_back: @upper_back }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @upper_back = UpperBack.find(params[:id])

    if @upper_back.update(upper_back_params)
      Event.create(user: current_user, event_type: "created_upper_back", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_upper_backs_path(@workout_data_id = params[:workout_data_id], @upper_back), notice: "Upper Back was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, upper_back: @upper_back }
    end
  end

  def destroy
    service = DestroyUpperBack.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Upper Back was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the upper_back."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def upper_back_params
    new_params = params.require(:upper_back).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end