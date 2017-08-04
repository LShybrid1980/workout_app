class HamstringsController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @hamstrings = @workout_data.hamstrings
    render :index, locals: { workout_data: @workout_data, hamstrings: @hamstrings }
  end

  def show
    @hamstring = Hamstring.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_hamstring", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, hamstring: @hamstring }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @hamstring = Hamstring.new
    render :new, locals: { workout_data: @workout_data, hamstring: @hamstring }
  end

  def create   
    @hamstring = Hamstring.new(hamstring_params)

    if @hamstring.save
      Event.create(user: current_user, event_type: "created_hamstring", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: hamstring_params })
      redirect_to workout_data_hamstring_path(@workout_data_id = params[:workout_data_id], @hamstring), notice: 'Hamstrings Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, hamstring: @hamstring }
    end
  end

  def edit
    @hamstring = Hamstring.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, hamstring: @hamstring }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @hamstring = Hamstring.find(params[:id])

    if @hamstring.update(hamstring_params)
      Event.create(user: current_user, event_type: "created_hamstring", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_hamstrings_path(@workout_data_id = params[:workout_data_id], @hamstring), notice: "Hamstrings was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, hamstring: @hamstring }
    end
  end

  def destroy
    service = DestroyHamstring.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Hamstrings was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the hamstring."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def hamstring_params
    new_params = params.require(:hamstring).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end