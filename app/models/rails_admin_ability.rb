class RailsAdminAbility
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :access, :rails_admin
      can :dashboard

      can :manage, User
      can :create, User
      can :manage, Category
      can :manage, Event
      can :manage, Group
      can :manage, News
    end
  end
end
