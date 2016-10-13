class PagesController < ApplicationController

  def home
    if current_user.nil?
      render :home
      return
    end
    if current_user.gympass_employee? or current_user.regular_end_user?
      lat = session[:lat]
      lng = session[:lng]
      @gyms = search_gyms_by_location(session[:lat], session[:lng])
      # binding.pry
    end
  end

  def search
    type_of_location = params[:type_of_location]
    # binding.pry
    if type_of_location.nil? or type_of_location == "current"
      @gyms = search_gyms_by_location(session[:lat], session[:lng])
    elsif type_of_location == "home"
      home_location = current_user.locations.home.first
      if home_location
        @gyms = search_gyms_by_location(home_location.latitude, home_location.longitude)
      else
        redirect_to root_path, alert: "Você não cadastrou a localização da sua casa"
        return
      end
    elsif type_of_location == "work"
      work_location = current_user.locations.work.first
      @gyms = search_gyms_by_location(work_location.latitude, work_location.longitude)
    end
    render :home
  end

  private

  def search_gyms_by_location(lat, lng)
    @gyms = Gym.approved.joins(:location).by_distance(origin: [lat, lng])
  end
end
