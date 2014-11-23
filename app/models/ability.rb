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
      can :create, Attendance, user_id: user.id
      can :destroy, Attendance, user_id: user.id

      can :read, Membership

      can :read, Group

      can :read, User
      can :update, User, id: user.id

    when user.guest?
    end
  end
end
