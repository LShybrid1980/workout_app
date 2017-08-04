class EllipticalsController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @ellipticals = @workout_data.ellipticals
    render :index, locals: { workout_data: @workout_data, ellipticals: @ellipticals }
  end

  def show
    @elliptical = Elliptical.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_elliptical", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, elliptical: @elliptical }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @elliptical = Elliptical.new
    render :new, locals: { workout_data: @workout_data, elliptical: @elliptical }
  end

  def create   
    @elliptical = Elliptical.new(elliptical_params)

    if @elliptical.save
      Event.create(user: current_user, event_type: "created_elliptical", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: elliptical_params })
      redirect_to workout_data_elliptical_path(@workout_data_id = params[:workout_data_id], @elliptical), notice: 'Ellipticals Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, elliptical: @elliptical }
    end
  end

  def edit
    @elliptical = Elliptical.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, elliptical: @elliptical }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @elliptical = Elliptical.find(params[:id])

    if @elliptical.update(elliptical_params)
      Event.create(user: current_user, event_type: "created_elliptical", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_ellipticals_path(@workout_data_id = params[:workout_data_id], @elliptical), notice: "Ellipticals was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, elliptical: @elliptical }
    end
  end

  def destroy
    service = DestroyElliptical.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Ellipticals was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the elliptical."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def elliptical_params
    new_params = params.require(:elliptical).permit(:status_type, :speed, :time, :distance, :resistance, :incline)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end