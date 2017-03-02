class DistrictPolicy < ApplicationPolicy
  def new?
    user && user.game.present?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
