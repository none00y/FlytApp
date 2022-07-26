class Ability 
  include CanCan::Ability
  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    end
    assign_common_abilities(user)
  end

  def assign_common_abilities(user)
    can :manage, User, id: user.id
    can [:index,:show], [Airplane,Airfield,Connection,Passenger]
  end
end