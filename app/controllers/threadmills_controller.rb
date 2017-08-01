class ThreadmillsController < ApplicationController
  before_action :set_threadmill, only: [:show, :edit, :update, :destroy]

  def index
    @threadmills = Threadmill.all
    render :index, locals: { threadmills: @threadmills}
  end

  def show
    render :show, locals: {threadmill: @threadmill }
  end

  def new
    @threadmill = Threadmill.new
  end

  def edit
    render :edit, locals: { threadmill: @threadmill }
  end

  def create
    @threadmill = Threadmill.new(threadmill_params)

    if @threadmill.save
      redirect_to @threadmill, notice: 'Threadmills Workout data was successfully created.'
    else
      render :new, locals: { threadmill: @threadmill }
    end
  end

  def update
    if @threadmill.update(threadmill_params)
      redirect_to @threadmill, notice: 'Threadmills Workout data was successfully updated.'
    else
      render :edit, locals: { threadmill: @threadmill }
    end
  end

  def destroy
    @threadmill.destroy
    redirect_to threadmills_path, notice: 'Threadmills Workout data was successfully destroyed.'
  end

  private

  def set_threadmill
   @threadmill = Threadmill.find(params[:id])
  end

  def threadmill_params
    params.require(:threadmill).permit(:name, :wieght, :set, :rep)
  end
end