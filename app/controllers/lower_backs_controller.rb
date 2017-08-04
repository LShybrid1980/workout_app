class LowerBacksController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @lower_backs = @workout_data.lower_backs
    render :index, locals: { workout_data: @workout_data, lower_backs: @lower_backs }
  end

  def show
    @lower_back = LowerBack.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_lower_back", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, lower_back: @lower_back }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @lower_back = LowerBack.new
    render :new, locals: { workout_data: @workout_data, lower_back: @lower_back }
  end

  def create   
    @lower_back = LowerBack.new(lower_back_params)

    if @lower_back.save
      Event.create(user: current_user, event_type: "created_lower_back", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: lower_back_params })
      redirect_to workout_data_lower_back_path(@workout_data_id = params[:workout_data_id], @lower_back), notice: 'Lower Backs Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, lower_back: @lower_back }
    end
  end

  def edit
    @lower_back = LowerBack.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, lower_back: @lower_back }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @lower_back = LowerBack.find(params[:id])

    if @lower_back.update(lower_back_params)
      Event.create(user: current_user, event_type: "created_lower_back", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_lower_backs_path(@workout_data_id = params[:workout_data_id], @lower_back), notice: "Lower Backs was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, lower_back: @lower_back }
    end
  end

  def destroy
    service = DestroyLowerBack.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Lower Backs was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the lower_back."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def lower_back_params
    new_params = params.require(:lower_back).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end