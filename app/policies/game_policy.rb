class GamePolicy < ApplicationPolicy
  def edit?
    user && record.user == user
  end

  def update?
    edit?
  end

  def destroy
    edit?
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
