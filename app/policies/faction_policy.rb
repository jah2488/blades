class FactionPolicy < ApplicationPolicy

  def new?
    user && user.game
  end

  def create?
    new?
  end

  def edit?
    user && user == record.game.user
  end

  def update?
    edit?
  end

  class Scope < Scope
    def resolve
      if user && user.game
        scope.where(game: user.game)
      else
        []
      end
    end
  end
end
