class AdvertisesController < ApplicationController
  layout "dashboard"

  before_action :set_advertise, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /advertises
  # GET /advertises.json
  def index
    @advertises = current_user.advertises.page(params[:page])
    respond_to do |format|
        format.html
        format.json
    end
  end

  # GET /advertises/1
  # GET /advertises/1.json
  def show
  end

  # GET /advertises/new
  def new
    @categories = Category.all
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

    @advertise = current_user.advertises.find_by_id(params[:id].to_i)
    if not @advertise then not_found end

    renew = Renew.where(:advertise_id => @advertise.id).order("renew_date desc").limit(1).select("renew_date, show_for_days")

    if not renew.empty?
      # Retrieve the last renew scheduled date
      last_renew = renew[0].renew_date
      last_renew_show_for_days = renew[0].show_for_days
      last_renew_date = last_renew + last_renew_show_for_days.days

    else
      last_renew_date = @advertise.deactive_date

    end

    # schedule the renew worker to run at the last expiration date
    jid = RenewWorker.perform_at(last_renew_date,
                                 {:id => params[:id]}.update(params.require(:advertise).permit(:cost,
                                                                                               :show_for_days)), 1)
    # Save the renew record to database so we can look back
    # and cancel them if user want
    renew = Renew.new(:user => current_user,
                      :advertise => @advertise,
                      :renew_date => last_renew_date,
                      :show_for_days => params[:advertise][:show_for_days],
                      :cost => params[:advertise][:cost],
                      :jid => jid)
    renew.save


    flash[:notice] = _("your renew order scheduled")
    redirect_to :dashboard_index
  end

  # GET /advertises/1/edit
  def edit
    @categories = Category.all
  end

  # POST /advertises
  # POST /advertises.json
  def create
    @advertise = Advertise.new(advertise_params)
    @advertise.user = current_user

    respond_to do |format|
      if @advertise.save

        Log.create(:logable => @advertise, :user => current_user,
                   :msg => _("new advertise \#%{id} created") % {:id => @advertise.id, asdasD: "Asd"})

        format.html { redirect_to target_url || @advertise, notice: 'Advertise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @advertise }
      else
        @categories = Category.all
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
                     :msg => _("\#%{id} advertise updated") % {:id => @advertise.id})
                     #:changes => @advertise.changes))

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
                 :msg => _("advertise deleted", :id => @advertise.id))

      @advertise.destroy
   else
      return forbidden
    end

    respond_to do |format|
      format.html { redirect_to target_url || advertises_url }
      format.json { head :no_content }
    end
  end

  # DELETE /advertises/1/renew/1
  # DELETE /advertises/renew/1.json
  def destroy_renew
    @renew = Renew.find_by_id(params[:renew_id].to_i)
    if not @renew then not_found end

    @advertise = Advertise.find_by_id(params[:id].to_i)
    if not @advertise then not_found end

    if @renew.user != current_user or @renew.advertise != @advertise
      forbidden
    end

    Log.create(:user => current_user,
               :msg => _("renew deleted", :id => @advertise.id,
                         :renew_id => @renew.id))

    # Delete the scheduled job
    queue = Sidekiq::ScheduledSet.new
    renew_job = queue.find_job(@renew.jid)
    if renew_job
      renew_job.delete
    end

    @renew.destroy

    flash[:notice] = _("renew removed")
    redirect_to :dashboard_index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertise
      @advertise = Advertise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertise_params
      params.require(:advertise).permit(:title, :description,
                                        :show_for_days, :cost,
                                        :size, :category_id, :tag_list)
    end

    private

    def forbidden
      render text: "You don't have access to this resource", status: :forbidden
    end
end
