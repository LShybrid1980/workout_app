class EllipticalsController < ApplicationController
  before_action :set_elliptical, only: [:show, :edit, :update, :destroy]

  def index
    @ellipticals = Elliptical.all
    render :index, locals: { ellipticals: @ellipticals}
  end

  def show
    render :show, locals: {elliptical: @elliptical }
  end

  def new
    @elliptical = Elliptical.new
  end

  def edit
    render :edit, locals: { elliptical: @elliptical }
  end

  def create
    @elliptical = Elliptical.new(elliptical_params)

    if @elliptical.save
      redirect_to @elliptical, notice: 'Ellipticals Workout data was successfully created.'
    else
      render :new, locals: { elliptical: @elliptical }
    end
  end

  def update
    if @elliptical.update(elliptical_params)
      redirect_to @elliptical, notice: 'Ellipticals Workout data was successfully updated.'
    else
      render :edit, locals: { elliptical: @elliptical }
    end
  end

  def destroy
    @elliptical.destroy
    redirect_to ellipticals_path, notice: 'Ellipticals Workout data was successfully destroyed.'
  end

  private

  def set_elliptical
   @elliptical = Elliptical.find(params[:id])
  end

  def elliptical_params
    params.require(:elliptical).permit(:name, :wieght, :set, :rep)
  end
end