class User < ApplicationRecord
  include Clearance::User
  has_many :games
  has_many :players

  def game
    games.last
  end

  def to_s
    email
  end
end
