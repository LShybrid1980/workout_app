class ArmsController < ApplicationController
  before_action :set_arm, only: [:show, :edit, :update, :destroy]

  def index
    @arms = Arm.all
    render :index, locals: { arms: @arms}
  end

  def show
    arm = @arms.find(params[:id])
    Event.create(user: current_user, event_type: "viewed_arm", details: { id: params[:id] })

    render :show, locals: { arm: @arm }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def new
    @arm = Arm.new
  end

  def create
    @arm = Arm.new(arm_params)

    if @arm.save
      redirect_to @arm, notice: 'Arms Workout data was successfully created.'
    else
      render :new, locals: { arm: @arm }
    end
  end

  def edit
    arm = @arms.find(params[:id])

    render :edit, locals: { arm: @arm }
  rescue ActiveRecord::RecordNotFound
    render "errors/not_found", status: :not_found
  end

  def update
    arm = @arms.find(params[:id])

    if arm.update(arm_params)
      Event.create(user: current_user, event_type: "updated_arm", details: { id: params[:id], params: arm_params })
      redirect_to [@arm]
    else
      render :edit, locals: { arm: @arm }
    end
  end

  def destroy
    service = DestroyArm.new(current_user, params[:id])
    service.call

    if service.success?
      redirect_to arm_path(service.Arm), notice: 'Arm was successfully destroyed.'
    elsif service.error == :not_found
      render "errors/not_found", status: :not_found
    else
      redirect_to arm_path(service.Arm), error: "An unknown error occurred and we couldn't destroy the arm."
    end
  end

  private

  def set_Arm
   @Arm = Arm.find(params[:id])
  end
end