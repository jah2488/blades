class DistrictPolicy < ApplicationPolicy
  def new?
    user && user.game.present?
  end

  class Scope < Scope
    def resolve
      scope.where(game: user.game)
    end
  end
end
