class UpperBodiesController < ApplicationController
  before_action :set_upper_body, only: [:show, :edit, :update, :destroy]

  def index
    @upper_bodies = UpperBody.all
    render :index, locals: { upper_bodies: @upper_bodies}
  end

  def show
    upper_body = @upper_bodies.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_upper_body", details: { id: params[:id] })

    render :show, locals: { upper_body: @upper_body }
      rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def new
    @upper_body = UpperBody.new
  end

 def create
    @upper_body = UpperBody.new(upper_body_params)

    if @upper_body.save
      redirect_to @upper_body, notice: 'Workout data was successfully created.'
    else
      render :new, locals: { upper_body: @upper_body }
    end
  end

  def edit
    upper_body = @upper_bodies.find(params[:id])

    render :edit, locals: { upper_body: @upper_body }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    upper_body = @upper_bodies.find(params[:id])

    if upper_body.update(upper_body_params)
      Event.create(user: current_user, event_type: "updated_upper_body", details: { id: params[:id], params: upper_body_params })
      redirect_to [@upper_body]
    else
      render :edit, locals: { upper_body: @upper_body }
    end
  end

  def destroy
    service = DestroyUpperBody.new(current_user, params[:id])
    service.call

    if service.success?
      redirect_to upper_body_path(service.lower_body), notice: 'Upper body was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to lower_body_path(service.lower_body), error: "An unknown error occurred and we couldn't destroy the lower body."
    end
  end

  private

  def set_upper_body
   @upper_body = UpperBody.find(params[:id])
  end
end