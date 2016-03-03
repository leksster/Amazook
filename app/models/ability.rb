class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin
      can :manage, :all
    else
      can [:edit, :update], Order, { user_id: user.id, aasm_state: 'in_progress' }
      can [:show], Order, user_id: user.id
      can :read, Book do |book|
        book.qty > 0
      end
      can :manage, User, id: user.id # ???
    end
  end
end
