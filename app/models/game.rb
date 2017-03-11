class Game < ApplicationRecord
  belongs_to :user
  has_many :factions
  has_many :users, foreign_key: :current_game_id
end
