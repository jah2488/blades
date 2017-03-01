class Faction < ApplicationRecord
  belongs_to :game
  belongs_to :category

  def as_json(*)
    super.merge({
      category: category,
      game: game
    })
  end
end
