class AbdominalsController < ApplicationController
  before_action :set_abdominal, only: [:show, :edit, :update, :destroy]

  def index
    @abdominals = Abdominal.all
    render :index, locals: { abdominals: @abdominals}
  end

  def show
    render :show, locals: {abdominal: @abdominal }
  end

  def new
    @abdominal = Abdominal.new
  end

  def edit
    render :edit, locals: { abdominal: @abdominal }
  end

  def create
    @abdominal = Abdominal.new(abdominal_params)

    if @abdominal.save
      redirect_to @abdominal, notice: 'Abs Workout data was successfully created.'
    else
      render :new, locals: { abdominal: @abdominal }
    end
  end

  def update
    if @abdominal.update(abdominal_params)
      redirect_to @abdominal, notice: 'Abs Workout data was successfully updated.'
    else
      render :edit, locals: { abdominal: @abdominal }
    end
  end

  def destroy
    @abdominal.destroy
    redirect_to abdominals_path, notice: 'Abs Workout data was successfully destroyed.'
  end

  private

  def set_abdominal
   @abdominal = Abdominal.find(params[:id])
  end

  def abdominal_params
    params.require(:abdominal).permit(:status_type, :weight, :set, :rep)
  end
end