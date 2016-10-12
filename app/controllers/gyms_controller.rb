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

  def gym_registration_params
    params.require(:gym_registration)
      .permit(:name, :cnpj, :location_latitude, :location_longitude, :opening_time_hour, :opening_time_min, :closing_time_hour, :closing_time_min, :gym_managers => [])
  end
end
