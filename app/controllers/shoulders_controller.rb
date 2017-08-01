class ShouldersController < ApplicationController
  before_action :set_shoulder, only: [:show, :edit, :update, :destroy]

  def index
    @shoulders = Shoulder.all
    render :index, locals: { shoulders: @shoulders}
  end

  def show
    render :show, locals: {shoulder: @shoulder }
  end

  def new
    @shoulder = Shoulder.new
  end

  def edit
    render :edit, locals: { shoulder: @shoulder }
  end

  def create
    @shoulder = Shoulder.new(shoulder_params)

    if @shoulder.save
      redirect_to @shoulder, notice: 'Shoulders Workout data was successfully created.'
    else
      render :new, locals: { shoulder: @shoulder }
    end
  end

  def update
    if @shoulder.update(shoulder_params)
      redirect_to @shoulder, notice: 'Shoulders Workout data was successfully updated.'
    else
      render :edit, locals: { shoulder: @shoulder }
    end
  end

  def destroy
    @shoulder.destroy
    redirect_to shoulders_path, notice: 'Shoulders Workout data was successfully destroyed.'
  end

  private

  def set_shoulder
   @shoulder = Shoulder.find(params[:id])
  end

  def shoulder_params
    params.require(:shoulder).permit(:name, :wieght, :set, :rep)
  end
end