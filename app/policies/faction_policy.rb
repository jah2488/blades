class FactionPolicy < ApplicationPolicy
  def edit?
    user && user.game == record.game
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
