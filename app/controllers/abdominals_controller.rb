class AbdominalsController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @abdominals = @workout_data.abdominals
    render :index, locals: { workout_data: @workout_data, abdominals: @abdominals }
  end

  def show
    @abdominal = Abdominal.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_abdominal", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, abdominal: @abdominal }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @abdominal = Abdominal.new
    render :new, locals: { workout_data: @workout_data, abdominal: @abdominal }
  end

  def create   
    @abdominal = Abdominal.new(abdominal_params)

    if @abdominal.save
      Event.create(user: current_user, event_type: "created_abdominal", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: abdominal_params })
      redirect_to workout_data_abdominal_path(@workout_data_id = params[:workout_data_id], @abdominal), notice: 'Abs Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, abdominal: @abdominal }
    end
  end

  def edit
    @abdominal = Abdominal.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, abdominal: @abdominal }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @abdominal = Abdominal.find(params[:id])

    if @abdominal.update(abdominal_params)
      Event.create(user: current_user, event_type: "created_abdominal", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_abdominals_path(@workout_data_id = params[:workout_data_id], @abdominal), notice: "Abs was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, abdominal: @abdominal }
    end
  end

  def destroy
    service = DestroyAbdominal.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Abs was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the abdominal."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def abdominal_params
    new_params = params.require(:abdominal).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end


