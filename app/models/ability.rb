class Ability
  include CanCan::Ability

  def initialize(user, camp)
    case
    when user.admin?
      can :manage, :all

    when user.user?
      can :read, Event
      can :catalog, Event
      can :update, Event, owner_id: user.id

      can :read, Attendance, event_id: user.self_attended_event_ids

      if camp.registration_open?
        can :create, Attendance, user_id: user.id
        can :destroy, Attendance, user_id: user.id
      end

      can :read, Membership

      can :read, Group

      can :read, User
      can :update, User, id: user.id

      can :read, News

    when user.guest?
      can :catalog, Event
      can :show, Event
    end
  end
end
