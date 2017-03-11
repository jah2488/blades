class CategoryPolicy < ApplicationPolicy
  def new?
    user && user.id == 1
  end

  def edit?
    new?
  end

  def create?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

  class Scope < Scope
    def resolve
      scope.where(game: user.game)
    end
  end
end
