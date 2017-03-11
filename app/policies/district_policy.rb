class DistrictPolicy < ApplicationPolicy
  def new?
    user && user.game
  end

  def edit?
    new? && record.game.user == user
  end

  def update?
    edit?
  end

  def create?
    new?
  end

  class Scope < Scope
    def resolve
      scope.where(game: user.game)
    end
  end
end
