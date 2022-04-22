# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :read, :update, :destroy, to: :ued

    return unless user.present?

    if user.admin?
      can :manage, :all
    else
      cannot :manage, :all
      can :ued, [Event, Task], user: user
      can :create, [Event, Task]
    end
  end
end
