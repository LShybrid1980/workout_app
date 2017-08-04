class ChestsController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @chests = @workout_data.chests
    render :index, locals: { workout_data: @workout_data, chests: @chests }
  end

  def show
    @chest = Chest.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_chest", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, chest: @chest }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @chest = Chest.new
    render :new, locals: { workout_data: @workout_data, chest: @chest }
  end

  def create   
    @chest = Chest.new(chest_params)

    if @chest.save
      Event.create(user: current_user, event_type: "created_chest", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: chest_params })
      redirect_to workout_data_chest_path(@workout_data_id = params[:workout_data_id], @chest), notice: 'Chests Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, chest: @chest }
    end
  end

  def edit
    @chest = Chest.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, chest: @chest }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @chest = Chest.find(params[:id])

    if @chest.update(chest_params)
      Event.create(user: current_user, event_type: "created_product", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_chests_path(@workout_data_id = params[:workout_data_id], @chest), notice: "Chests was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, chest: @chest }
    end
  end

  def destroy
    service = DestroyChest.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Chests was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the chest."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def chest_params
    new_params = params.require(:chest).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end