class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Guest.new

    case
    when user.admin?
      can :manage, :all

    when user.user?
      can :read, Event
      can :update, Event, owner_id: user.id

      can :read, Attendance, event_id: user.event_ids
      can :destroy, Attendance, user_id: user.id, mandatory: false

      can :read, Membership

      can :read, Group
    when user.guest?
    end
  end
end
