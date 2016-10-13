class GymsController < ApplicationController

  def new
    @gym_registration = GymRegistration.new
  end

  def create
    @gym_registration = GymRegistration.new(gym_registration_params)
    if @gym_registration.valid?
      Gym.transaction do
        gym = @gym_registration.save(current_user)
        if gym.persisted?
          redirect_to root_path, notice: "Academia cadastrada com sucesso. Aguardando aprovação!"
        end
      end
    else
      render :new
    end
  end

  def show
    @gym = Gym.approved.find(params[:id])
  end

  def index
    if current_user.gympass_employee?
      @gyms = Gym.all
    else
      @gyms = current_user.gyms
    end
  end

  def approve
    unless current_user.gympass_employee?
      redirect_to gyms_path, error: "Ação não permitida!"
      return
    end
    @gym = Gym.find(params[:id])
    if @gym
      Gym.transaction do
        @gym.approved!
        GymApprovalMailer.approval_email(@gym).deliver_now
        redirect_to gyms_path, notice: "#{@gym.name} foi aprovada com sucesso!"
      end
    else
      redirect_to gyms_path, error: "Academia não encontrada!"
    end
  end

  def destroy
    redirect_to gyms_path, error: "Ação não permitida!" unless current_user.gympass_employee? or current_user.gym_manager?
    if current_user.gym_manager?
      @gym = current_user.gyms.find(params[:id])
    elsif current_user.gympass_employee?
      @gym = Gym.find(params[:id])
    end
    if @gym
      @gym.destroy!
      redirect_to gyms_path, notice: "#{@gym.name} foi removida com sucesso!"
    else
      redirect_to gyms_path, error: "Academia não encontrada!"
    end
  end

  def gym_registration_params
    params.require(:gym_registration)
      .permit(:name, :cnpj, :location_latitude, :location_longitude, :opening_time_hour, :opening_time_min, :closing_time_hour, :closing_time_min, :gym_managers => [])
  end
end
