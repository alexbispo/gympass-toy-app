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
      redirect_to gym_path(gym), alert: "Não foi possível completar a sua solicitação. Por favor contate o suporte."
    end
  end

  def index
    if current_user.gympass_employee?
      @daily_tokens = DailyToken.joins(:gym).where("gyms.id = ?", params[:gym_id])
    else
      @daily_tokens = current_user.gyms.find(params[:gym_id]).daily_tokens
    end
  end

  def validate
    if current_user.gympass_employee?
      @daily_token = DailyToken.find(params[:id])
    else
      @daily_token = DailyToken.joins(gym: :users).where("users.id = ? and daily_tokens.id = ?", current_user.id, params[:id]).first
    end
    if @daily_token
      if @daily_token.validate!
        redirect_to daily_tokens_path(gym_id: @daily_token.gym.id), notice: "Token Diário aprovado com sucesso."
      else
        redirect_to daily_tokens_path(gym_id: @daily_token.gym.id), alert: "Não foi possível completar a sua solicitação. Contate o suporte."
      end
    end
  end

  private

  def user_has_retrieved_today_token?
    current_user.daily_tokens.any? { |t| t.created_at.between?(Time.current.beginning_of_day, Time.current.end_of_day) }
  end
end
