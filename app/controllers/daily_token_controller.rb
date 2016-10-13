class DailyTokenController < ApplicationController

  def create
    gym = Gym.find(params[:gym_id])
    unless current_user.daily_tokens.empty?
       if user_has_retrieved_today_token?
         redirect_to gym_path(gym), alert: "Você já solicitou o seu token diário hoje."
         return
       end
    end
    @daily_token = current_user.daily_tokens.build(gym: gym)
    if @daily_token.save
      redirect_to gym_path(gym), notice: "Solicitação realizada com sucesso. Aguardando aprovação"
    else
      redirect_to gym_path(gym), alert: "Não foi possível completar a sua solicitação. Tente novamente mais tarde."
    end
  end

  private

  def user_has_retrieved_today_token?
    current_user.daily_tokens.any? { |t| t.created_at.between?(Time.current.beginning_of_day, Time.current.end_of_day) }
  end
end
