class CategoriesController < ApplicationController
  layout "dashboard"

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /categories
  # GET /categories.json
  def index
    authorize! :read, Category
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    authorize! :read, Category
  end

  # GET /categories/new
  def new
    authorize! :write, Category
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    authorize! :write, Category
  end

  # POST /categories
  # POST /categories.json
  def create
    authorize! :write, Category
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: _('Category was successfully created.') }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    authorize! :write, Category

    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: _('Category was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    authorize! :write, Category

    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :cssclass)
    end
end
