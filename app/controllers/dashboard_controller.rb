class DashboardController < ApplicationController
  def index
    render locals: {
      my_games: current_user.games,
      playing_games: current_user.playing_games
    }
  end
end
