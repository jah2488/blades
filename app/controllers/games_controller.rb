class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = policy_scope(Game)
  end

  # GET /games/1
  def show
    authorize @game
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    authorize @game
  end

  # POST /games
  def create
    @game      = Game.new(game_params)
    @game.user = current_user

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /games/1
  def update
    authorize @game
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /games/1
  def destroy
    authorize @game
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find_by(slug: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game).permit(:user_id, :name)
    end
end
