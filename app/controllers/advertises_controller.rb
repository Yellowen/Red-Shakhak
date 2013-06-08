class AdvertisesController < ApplicationController
  # TODO: Remove index from routes
  before_action :set_advertise, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /advertises
  # GET /advertises.json
  def index
    @advertises = current_user.advertises
  end

  # GET /advertises/1
  # GET /advertises/1.json
  def show
  end

  # GET /advertises/new
  def new
    @advertise = Advertise.new
    @advertise.user = current_user
  end

  # GET /advertise/1/renew
  def renew
    begin
      @advertise = current_user.advertises.find(params[:id])
      @advertise.show_for_days = 0
      @advertise.cost = 0
    rescue ActiveRecord::RecordNotFound
      not_found
    end

  end

  def do_renew
    begin
      @advertise = current_user.advertises.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      not_found
    end

    RenewWorker.perform_at({:id => params[:id]}.update(params.require(:advertise).permit(:cost,
                                                                                            :show_for_days)), 1)
    flash[:notice] = t("your renew order scheduled")
    render :dashboard_index
  end
  # GET /advertises/1/edit
  def edit
  end

  # POST /advertises
  # POST /advertises.json
  def create
    @advertise = Advertise.new(advertise_params)
    @advertise.user = current_user

    respond_to do |format|
      if @advertise.save

        Log.create(:logable => @advertise, :user => current_user,
                   :msg => t(:new_advertise_created, :id => @advertise.id))

        format.html { redirect_to target_url || @advertise, notice: 'Advertise was successfully created.' }
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
      if @advertise.user == current_user
        if @advertise.update(advertise_params)
          Log.create(:logable => @advertise, :user => current_user,
                     :msg => t(:advertise_updated, :changes => @advertise.changes))

          format.html { redirect_to target_url || @advertise, notice: 'Advertise was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @advertise.errors, status: :unprocessable_entity }
        end
      else
        return forbidden
      end
    end
  end

  # DELETE /advertises/1
  # DELETE /advertises/1.json
  def destroy
    if @advertise.user == current_user
      # BUG: Log entry should contains the removed advertise
      #      id even after its removal.
      Log.create(:user => current_user,
                 :msg => t(:advertise_deleted, :id => @advertise.id))

      @advertise.destroy
   else
      return forbidden
    end

    respond_to do |format|
      format.html { redirect_to target_url || advertises_url }
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

    private

    def forbidden
      render text: "You don't have access to this resource", status: :forbidden
    end
end
