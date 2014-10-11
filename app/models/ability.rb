class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Guest.new

    case
    when user.admin?
      can :manage, :all
    when user.user?
      can :read, Workshop
      can :update, Workshop, owner_id: user.id
      can :read, Attendance, workshop_id: user.workshop_ids
    when user.guest?
    end
  end
end
