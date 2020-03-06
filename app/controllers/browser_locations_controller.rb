class BrowserLocationsController < ApplicationController
  before_action :set_browser_location, only: [:show, :edit, :update, :destroy]

  # GET /browser_locations
  # GET /browser_locations.json
  def index
    @browser_locations = BrowserLocation.all
  end

  # GET /browser_locations/1
  # GET /browser_locations/1.json
  def show
  end

  # GET /browser_locations/new
  def new
    @browser_location = BrowserLocation.new
  end

  # GET /browser_locations/1/edit
  def edit
  end

  # POST /browser_locations
  # POST /browser_locations.json
  def create
    @browser_location = BrowserLocation.new(browser_location_params)

    respond_to do |format|
      if @browser_location.save
        format.html { redirect_to @browser_location, notice: 'Browser location was successfully created.' }
        format.json { render :show, status: :created, location: @browser_location }
      else
        format.html { render :new }
        format.json { render json: @browser_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /browser_locations/1
  # PATCH/PUT /browser_locations/1.json
  def update
    respond_to do |format|
      if @browser_location.update(browser_location_params)
        format.html { redirect_to @browser_location, notice: 'Browser location was successfully updated.' }
        format.json { render :show, status: :ok, location: @browser_location }
      else
        format.html { render :edit }
        format.json { render json: @browser_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /browser_locations/1
  # DELETE /browser_locations/1.json
  def destroy
    @browser_location.destroy
    respond_to do |format|
      format.html { redirect_to browser_locations_url, notice: 'Browser location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_browser_location
      @browser_location = BrowserLocation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def browser_location_params
      params.require(:browser_location).permit(:lonlat, :accuracy)
    end
end
