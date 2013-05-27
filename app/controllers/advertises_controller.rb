class AdvertisesController < ApplicationController
  before_action :set_advertise, only: [:show, :edit, :update, :destroy]

  # GET /advertises
  # GET /advertises.json
  def index
    @advertises = Advertise.all
  end

  # GET /advertises/1
  # GET /advertises/1.json
  def show
  end

  # GET /advertises/new
  def new
    @advertise = Advertise.new
  end

  # GET /advertises/1/edit
  def edit
  end

  # POST /advertises
  # POST /advertises.json
  def create
    @advertise = Advertise.new(advertise_params)

    respond_to do |format|
      if @advertise.save
        format.html { redirect_to @advertise, notice: 'Advertise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @advertise }
      else
        format.html { render action: 'new' }
        format.json { render json: @advertise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advertises/1
  # PATCH/PUT /advertises/1.json
  def update
    respond_to do |format|
      if @advertise.update(advertise_params)
        format.html { redirect_to @advertise, notice: 'Advertise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @advertise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertises/1
  # DELETE /advertises/1.json
  def destroy
    @advertise.destroy
    respond_to do |format|
      format.html { redirect_to advertises_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertise
      @advertise = Advertise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertise_params
      params.require(:advertise).permit(:title, :description, :show_for_days, :cost)
    end
end
