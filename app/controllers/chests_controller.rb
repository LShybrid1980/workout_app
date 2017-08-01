class ChestsController < ApplicationController
  before_action :set_chest, only: [:show, :edit, :update, :destroy]

  def index
    @chests = Chest.all
    render :index, locals: { chests: @chests}
  end

  def show
    render :show, locals: {chest: @chest }
  end

  def new
    @chest = Chest.new
  end

  def edit
    render :edit, locals: { chest: @chest }
  end

  def create
    @chest = Chest.new(chest_params)

    if @chest.save
      redirect_to @chest, notice: 'Chests Workout data was successfully created.'
    else
      render :new, locals: { chest: @chest }
    end
  end

  def update
    if @chest.update(chest_params)
      redirect_to @chest, notice: 'Chests Workout data was successfully updated.'
    else
      render :edit, locals: { chest: @chest }
    end
  end

  def destroy
    @chest.destroy
    redirect_to chests_path, notice: 'Chests Workout data was successfully destroyed.'
  end

  private

  def set_chest
   @chest = Chest.find(params[:id])
  end

  def chest_params
    params.require(:chest).permit(:name, :wieght, :set, :rep)
  end
end