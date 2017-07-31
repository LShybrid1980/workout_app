class LegsController < ApplicationController
  before_action :set_leg, only: [:show, :edit, :update, :destroy]

  def index
    @legs = Leg.all
    render :index, locals: { legs: @legs }
  end

  def show
    leg = @legs.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_leg", details: { id: params[:id] })

    render :show, locals: { leg: @leg }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def new
    leg = @legs.new

    render :new, locals: { leg: @leg }
  end

  def create
    leg = @legs.new(leg_params)
    if leg.save
      Event.create(user: current_user, event_type: "created_leg", details: { id: params[:id], params: leg_params })
      redirect_to [@leg]
    else
      render :new, locals: { leg: @leg }
    end
  end

  def edit
    leg = @legs.find(params[:id])

    render :edit, locals: { leg: leg }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    leg = @legs.find(params[:id])

    if leg.update(leg_params)
      Event.create(user: current_user, event_type: "updated_leg", details: { id: params[:id], params: leg_params })
      redirect_to [@leg]
    else
      render :edit, locals: { leg: @leg }
    end
  end

  def destroy
    service = DestroyLeg.new(current_user, params[:id])
    service.call

    if service.success?
      redirect_to leg_path(service.Leg), notice: 'Leg was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to Leg_path(service.Leg), error: "An unknown error occurred and we couldn't destroy the leg."
    end
  end

  private

  def set_leg
   @leg = leg.find(params[:id])
  end
end