class RailsAdminAbility
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :access, :rails_admin
      can :dashboard

      can :manage, User
      can :manage, Category
      can :manage, Event
      can :manage, Group
      can :manage, News
      can :manage, EmergencyNumber

      can :update, Camp, schema_name: Apartment::Tenant.current
      can :read, Camp, schema_name: Apartment::Tenant.current
    end
  end
end
