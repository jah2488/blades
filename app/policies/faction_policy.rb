class FactionPolicy < ApplicationPolicy
  def edit?
    user && user.game == record.game
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
