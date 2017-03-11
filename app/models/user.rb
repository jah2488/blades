class User < ApplicationRecord
  include Clearance::User
  has_many :games
  has_many :user_players
  has_many :players, through: :user_players
  has_many :playing_games, through: :players, source: :game

  def multiple_games?
    games.where(active: true).count > 1
  end

  def game
    @game ||= Game.find_by(id: current_game_id) || games.last
  end

  def to_s
    email
  end
end
