class FactionPolicy < ApplicationPolicy

  def new?
    user && user == record.game.user
  end
  
  def edit?
    user && user == record.game.user
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
