class CategoryPolicy < ApplicationPolicy
  def edit?
    user && user.id == 1
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
