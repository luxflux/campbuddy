class RailsAdminAbility
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :access, :rails_admin
      can :dashboard

      can :read, User
      can :read, Category
      can :manage, Event
      can :manage, Group
    end
  end
end
