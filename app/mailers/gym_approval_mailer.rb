class GymApprovalMailer < ApplicationMailer

  def approval_email(gym)
    @gym = gym
    mail({
      to: gym_manager_email_list,
      bcc: ["sign ups <signups@gympasstoy.net>"],
      subject: "[#{@gym.name}][Aprovação]"
    })
  end

  private

  def gym_manager_email_list
    @gym.users.inject([]) { |list, u| list << u.email }
  end
end
