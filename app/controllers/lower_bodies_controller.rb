class LowerBodiesController < ApplicationController
  before_action :set_lower_body, only: [:show, :edit, :update, :destroy]

  def index
    @lower_bodies = LowerBody.all
    render :index, locals: { lower_bodies: @lower_bodies }
  end

  def show
    lower_body = @lower_bodies.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_lower_body", details: { id: params[:id] })

    render :show, locals: { lower_body: @lower_body }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def new
    lower_body = @lower_bodies.new

    render :new, locals: { lower_body: @lower_body }
  end

  def create
    lower_body = @lower_bodies.new(lower_body_params)
    if lower_body.save
      Event.create(user: current_user, event_type: "created_lower_body", details: { id: params[:id], params: lower_body_params })
      redirect_to [@lower_body]
    else
      render :new, locals: { lower_body: @lower_body }
    end
  end

  def edit
    lower_body = @lower_bodies.find(params[:id])

    render :edit, locals: { lower_body: @lower_body }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    lower_body = @lower_bodies.find(params[:id])

    if lower_body.update(lower_body_params)
      Event.create(user: current_user, event_type: "updated_lower_body", details: { id: params[:id], params: lower_body_params })
      redirect_to [@lower_body]
    else
      render :edit, locals: { lower_body: @lower_body }
    end
  end

  def destroy
    service = DestroyLowerBody.new(current_user, params[:id])
    service.call

    if service.success?
      redirect_to lower_body_path(service.lower_body), notice: 'Lower body was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to lower_body_path(service.lower_body), error: "An unknown error occurred and we couldn't destroy the lower body."
    end
  end

  private

  def set_lower_body
   @lower_body = LowerBody.find(params[:id])
  end
end