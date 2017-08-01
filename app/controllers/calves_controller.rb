class CalvesController < ApplicationController
  before_action :set_calf, only: [:show, :edit, :update, :destroy]

  def index
    @calfs = Calf.all
    render :index, locals: { calfs: @calfs}
  end

  def show
    render :show, locals: {calf: @calf }
  end

  def new
    @calf = Calf.new
  end

  def edit
    render :edit, locals: { calf: @calf }
  end

  def create
    @calf = Calf.new(calf_params)

    if @calf.save
      redirect_to @calf, notice: 'Calves Workout data was successfully created.'
    else
      render :new, locals: { calf: @calf }
    end
  end

  def update
    if @calf.update(calf_params)
      redirect_to @calf, notice: 'Calves Workout data was successfully updated.'
    else
      render :edit, locals: { calf: @calf }
    end
  end

  def destroy
    @calf.destroy
    redirect_to calfs_path, notice: 'Calves Workout data was successfully destroyed.'
  end

  private

  def set_calf
   @calf = Calf.find(params[:id])
  end

  def calf_params
    params.require(:calf).permit(:name, :wieght, :set, :rep)
  end
end