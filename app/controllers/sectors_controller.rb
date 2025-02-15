class SectorsController < ApplicationController
  before_action :set_sector, only: %i[ show edit update destroy ]
  before_action :set_units, only: %i[ new edit create update ]
  load_and_authorize_resource
  # GET /sectors or /sectors.json
  def index
    @sectors = Sector.includes(:unit).all
  end

  # GET /sectors/1 or /sectors/1.json
  def show
  end

  # GET /sectors/new
  def new
    @sector = Sector.new
    @active_units = Unit.where(active: true) # Filtra apenas unidades ativas
  end

  # GET /sectors/1/edit
  def edit
    @sector = Sector.find(params[:id])
    @active_units = Unit.where(active: true).or(Unit.where(id: @sector.unit_id))
  end

  # POST /sectors or /sectors.json
  def create
    @sector = Sector.new(sector_params)

    respond_to do |format|
      if @sector.save
        format.html { redirect_to @sector, notice: "Sector was successfully created." }
        format.json { render :show, status: :created, location: @sector }
      else
        @active_units = Unit.where(active: true)
        set_units
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sectors/1 or /sectors/1.json
  def update
    respond_to do |format|
      if @sector.update(sector_params)
        format.html { redirect_to @sector, notice: "Sector was successfully updated." }
        format.json { render :show, status: :ok, location: @sector }
      else
        @active_units = Unit.where(active: true).or(Unit.where(id: @sector.unit_id))
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sectors/1 or /sectors/1.json
  def destroy
    @sector.destroy!

    respond_to do |format|
      format.html { redirect_to sectors_path, status: :see_other, notice: "Sector was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def employees
    @employees = Employee.where(sector_id: params[:id])
    render json: @employees.select(:id, :name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sector
      @sector = Sector.find(params.expect(:id))
    end

    def set_units
      @units = Unit.all
    end

    # Only allow a list of trusted parameters through.
    def sector_params
      params.expect(sector: [ :name, :unit_id, :active ])
    end
end
