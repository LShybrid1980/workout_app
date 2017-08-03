class CardiosController < ApplicationController
  before_action :set_cardio, only: [:show, :edit, :update, :destroy]

  def index
    @cardios = Cardio.all
    render :index, locals: { cardios: @cardios}
  end

  def show
    cardio = @cardios.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_cardio", details: { id: params[:id] })

    render :show, locals: { cardio: @cardio }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def new
    @cardio = Cardio.new
  end

  def create
    @cardio = Cardio.new(cardio_params)

    if @cardio.save
      redirect_to @cardio, notice: 'Workout data was successfully created.'
    else
      render :new, locals: { cardio: @cardio }
    end
  end

  def edit
    cardio = @cardios.find(params[:id])

    render :edit, locals: { cardio: @cardio }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    cardio = @cardios.find(params[:id])

    if cardio.update(cardio_params)
      Event.create(user: current_user, event_type: "updated_cardio", details: { id: params[:id], params: cardio_params })
      redirect_to [@cardio]
    else
      render :edit, locals: { cardio: @cardio }
    end
  end

  def destroy
    service = DestroyCardio.new(current_user, params[:id])
    service.call

    if service.success?
      redirect_to cardio_path(service.Cardio), notice: 'Cardio was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to cardio_path(service.Cardio), error: "An unknown error occurred and we couldn't destroy the cardio."
    end
  end

  private

  def set_cardio  
   @cardio = Cardio.find(params[:id])
  end
end