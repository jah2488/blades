class DistrictPolicy < ApplicationPolicy
  def new?
    user && user.game.present?
  end

  def edit?
    new? && record.game.user == user
  end

  class Scope < Scope
    def resolve
      scope.where(game: user.game)
    end
  end
end
