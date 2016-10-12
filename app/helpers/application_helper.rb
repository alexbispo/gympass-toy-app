module ApplicationHelper
  def gym_managers_coll(exclude = nil)
     User.gym_manager.merge(User.confirmed)
    .where.not(email: exclude)
    .order(:email).inject([]) { |coll, gm| coll << [gm.id, gm.email] }
  end
end
