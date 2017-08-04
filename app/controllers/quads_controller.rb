class QuadsController < ApplicationController   
  before_action :find_workout_data, only: [:index, :new, :show, :edit]
  before_action :authenticate_user!
  
  def index
    @quads = @workout_data.quads
    render :index, locals: { workout_data: @workout_data, quads: @quads }
  end

  def show
    @quad = Quad.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_quad", details: { id: params[:id], workout_data_id: params[:workout_data_id] })

    render :show, locals: { workout_data: @workout_data, quad: @quad }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found  
  end

  def new
    @quad = Quad.new
    render :new, locals: { workout_data: @workout_data, quad: @quad }
  end

  def create   
    @quad = Quad.new(quad_params)

    if @quad.save
      Event.create(user: current_user, event_type: "created_quad", details: { id: params[:id], workout_data_id: params[:workout_data_id], params: quad_params })
      redirect_to workout_data_quad_path(@workout_data_id = params[:workout_data_id], @quad), notice: 'Quads Workout data was successfully created.'
    else
      render :new, locals: { workout_data: @workout_data, quad: @quad }
    end
  end

  def edit
    @quad = Quad.find(params[:id])

    render :edit, locals: { workout_data: @workout_data, quad: @quad }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    @quad = Quad.find(params[:id])

    if @quad.update(quad_params)
      Event.create(user: current_user, event_type: "created_quad", details: { id: params[:id], manufacturer_id: params[:manufacturer_id], params: product_params })
      redirect_to workout_data_quads_path(@workout_data_id = params[:workout_data_id], @quad), notice: "Quads was updated successfuly."
    else
      render :edit, locals: { workout_data: @workout_data, quad: @quad }
    end
  end

  def destroy
    service = DestroyQuad.new(current_user, params[:id], params[:workout_data_id])
    service.call

    if service.success?
      redirect_to workout_data_path(service.workout_data), notice: 'Quads was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to workout_data_path(service.workout_data), error: "An unknown error occurred and we couldn't destroy the quad."
    end
  end

  private

  def find_workout_data
    @workout_data = WorkoutData.find(params[:workout_data_id])
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def quad_params
    new_params = params.require(:quad).permit(:status_type, :weight, :set, :rep)
    new_params['workout_data_id'] = params[:workout_data_id]
    new_params
  end 
end