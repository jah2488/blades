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
      scope.preload(:factions, :characters, :game).where(game_id: user.current_game_id || user.game.id)
    end
  end
end
