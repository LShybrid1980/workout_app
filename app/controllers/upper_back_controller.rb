class UpperBacksController < ApplicationController
  before_action :set_upper_back, only: [:show, :edit, :update, :destroy]

  def index
    @upper_backs = UpperBack.all
    render :index, locals: { upper_backs: @upper_backs}
  end

  def show
    render :show, locals: {upper_back: @upper_back }
  end

  def new
    @upper_back = UpperBack.new
  end

  def edit
    render :edit, locals: { upper_back: @upper_back }
  end

  def create
    @upper_back = UpperBack.new(upper_back_params)

    if @upper_back.save
      redirect_to @upper_back, notice: 'Upper Backs Workout data was successfully created.'
    else
      render :new, locals: { upper_back: @upper_back }
    end
  end

  def update
    if @upper_back.update(upper_back_params)
      redirect_to @upper_back, notice: 'Upper Backs Workout data was successfully updated.'
    else
      render :edit, locals: { upper_back: @upper_back }
    end
  end

  def destroy
    @upper_back.destroy
    redirect_to upper_backs_path, notice: 'Upper Backs Workout data was successfully destroyed.'
  end

  private

  def set_upper_back
   @upper_back = UpperBack.find(params[:id])
  end

  def upper_back_params
    params.require(:upper_back).permit(:name, :wieght, :set, :rep)
  end
end