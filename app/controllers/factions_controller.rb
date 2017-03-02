class FactionsController < ApplicationController
  before_action :set_faction, only: [:show, :edit, :update, :destroy]

  # GET /factions
  def index
    @factions = policy_scope(Faction)
  end

  # GET /factions/1
  def show
  end

  # GET /factions/new
  def new
    @faction = Faction.new
  end

  # GET /factions/1/edit
  def edit
  end

  # POST /factions
  def create
    @faction = Faction.new(faction_params)
    @faction.game = current_user.game

    if @faction.save
      redirect_to @faction, notice: 'Faction was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /factions/1
  def update
    if @faction.update(faction_params)
      respond_to do |f|
        f.json do
          render json: "Success"
        end
        f.html do
          redirect_to @faction, notice: 'Faction was successfully updated.'
        end
      end
    else
      render :edit
    end
  end

  # DELETE /factions/1
  def destroy
    @faction.destroy
    redirect_to factions_url, notice: 'Faction was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faction
      @faction = Faction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def faction_params
      params.require(:faction).permit(:game_id, :category_id, :name, :description, :reputation, :hold, :turf, :faction_status)
    end
end
