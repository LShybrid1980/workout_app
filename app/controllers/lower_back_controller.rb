class LowerBacksController < ApplicationController
  before_action :set_lower_back, only: [:show, :edit, :update, :destroy]

  def index
    @lower_backs = LowerBack.all
    render :index, locals: { lower_backs: @lower_backs}
  end

  def show
    render :show, locals: {lower_back: @lower_back }
  end

  def new
    @lower_back = LowerBack.new
  end

  def edit
    render :edit, locals: { lower_back: @lower_back }
  end

  def create
    @lower_back = Lowerback.new(lower_back_params)

    if @lower_back.save
      redirect_to @lower_back, notice: 'Lower Backs Workout data was successfully created.'
    else
      render :new, locals: { lower_back: @lower_back }
    end
  end

  def update
    if @lower_back.update(lower_back_params)
      redirect_to @lower_back, notice: 'Lower Backs Workout data was successfully updated.'
    else
      render :edit, locals: { lower_back: @lower_back }
    end
  end

  def destroy
    @lower_back.destroy
    redirect_to lower_backs_path, notice: 'Lower Backs Workout data was successfully destroyed.'
  end

  private

  def set_lower_back
   @lower_back = LowerBack.find(params[:id])
  end

  def lower_back_params
    params.require(:lower_back).permit(:name, :wieght, :set, :rep)
  end
end