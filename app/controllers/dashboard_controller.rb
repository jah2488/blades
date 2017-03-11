class DashboardController < ApplicationController
  def landing
    render layout: 'landing'
  end

  def index
    render locals: {
      my_games: current_user.games,
      playing_games: Array(current_user.game)
    }
  end
end
