class HamstringsController < ApplicationController
  before_action :set_hamstring, only: [:show, :edit, :update, :destroy]

  def index
    @hamstrings = Hamstring.all
    render :index, locals: { hamstrings: @hamstrings}
  end

  def show
    render :show, locals: {hamstring: @hamstring }
  end

  def new
    @hamstring = Hamstring.new
  end

  def edit
    render :edit, locals: { hamstring: @hamstring }
  end

  def create
    @hamstring = Hamstring.new(hamstring_params)

    if @hamstring.save
      redirect_to @hamstring, notice: 'Hamstrings Workout data was successfully created.'
    else
      render :new, locals: { hamstring: @hamstring }
    end
  end

  def update
    if @hamstring.update(hamstring_params)
      redirect_to @hamstring, notice: 'Hamstrings Workout data was successfully updated.'
    else
      render :edit, locals: { hamstring: @hamstring }
    end
  end

  def destroy
    @hamstring.destroy
    redirect_to hamstrings_path, notice: 'Hamstrings Workout data was successfully destroyed.'
  end

  private

  def set_hamstring
   @hamstring = Hamstring.find(params[:id])
  end

  def hamstring_params
    params.require(:hamstring).permit(:status_type, :weight, :set, :rep)
  end
end