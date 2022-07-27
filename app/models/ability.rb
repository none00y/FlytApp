class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new

    can :manage, :all if user.admin?
    assign_common_abilities(user)
  end

  def assign_common_abilities(user)
    can :manage, User, id: user.id
    can [:index, :show], [Airplane, Airfield, Connection, Passenger]
  end
end
