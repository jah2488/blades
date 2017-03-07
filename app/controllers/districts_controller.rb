class DistrictsController < ApplicationController
  before_action :set_district, only: [:show, :edit, :update, :destroy]

  # GET /districts
  def index
    @districts = District.where(game: current_user.game)
  end

  # GET /districts/1
  def show
  end

  # GET /districts/new
  def new
    @district = District.new
  end

  # GET /districts/1/edit
  def edit
  end

  # POST /districts
  def create
    @district = District.new(district_params)
    @district.game = current_user.game

    if @district.save
      redirect_to @district, notice: 'District was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /districts/1
  def update
    if @district.update(district_params)
      respond_to do |f|
        f.json do
          render json: "Success"
        end
        f.html do
          redirect_to @district, notice: 'District was successfully updated.'
        end
      end
    else
      respond_to do |f|
        f.json do
          render json: "Failed"
        end
        f.html do
          render :edit
        end
      end
    end
  end

  # DELETE /districts/1
  def destroy
    @district.destroy
    redirect_to districts_url, notice: 'District was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_district
    @district = District.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def district_params
    params.require(:district).permit(:game_id, :name, :description, :faction_ids, :wealth, :security_and_safety, :criminal_influence, :occult_influence, faction_ids: [])
  end
end
