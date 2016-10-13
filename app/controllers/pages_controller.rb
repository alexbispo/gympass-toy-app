class PagesController < ApplicationController

  def home
    if logged_in?
      if current_user.gympass_employee? or current_user.regular_end_user?
        @gyms = Gym.approved.joins(:location).by_distance(origin: [-23.6191331, -46.7714152])
      end
    end
  end

end
