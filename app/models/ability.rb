class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Guest.new

    case
    when user.admin?
      can :manage, :all
    when user.user?
      can :read, Workshop
    when user.guest?
    end
  end
end
