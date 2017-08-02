class BicepsController < ApplicationController
  before_action :set_bicep, only: [:show, :edit, :update, :destroy]

  def index
    @biceps = Bicep.all
    render :index, locals: { biceps: @biceps}
  end

  def show
    render :show, locals: {bicep: @bicep }
  end

  def new
    @bicep = Bicep.new
    # render :new, locals: { bicep: @bicep }
  end

  def edit
    render :edit, locals: { bicep: @bicep }
  end

  def create
    @bicep = Bicep.new(bicep_params)

    if @bicep.save
      redirect_to @bicep, notice: 'Biceps Workout data was successfully created.'
    else
      render :new, locals: { bicep: @bicep }
    end
  end

  def update
    if @bicep.update(bicep_params)
      redirect_to @bicep, notice: 'Biceps Workout data was successfully updated.'
    else
      render :edit, locals: { bicep: @bicep }
    end
  end

  def destroy
    @bicep.destroy
    redirect_to biceps_path, notice: 'Biceps Workout data was successfully destroyed.'
  end

  private

  def set_bicep
   @bicep = Bicep.find(params[:id])
  end

  def bicep_params
    params.require(:bicep).permit(:status_type, :weight, :set, :rep)
  end
end