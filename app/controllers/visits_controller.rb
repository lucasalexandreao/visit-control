class VisitsController < ApplicationController
  before_action :set_visit, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /visits or /visits.json
  def index
    if current_user.employee?
      @visits = Visit.accessible_by(current_ability)
    else
      @visits = Visit.all
    end
  end

  # GET /visits/1 or /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    @visit = Visit.new
    @visitor = Visitor.new
    @active_units = Unit.where(active: true)
    @active_sectors = Sector.where(active: true, unit_id: current_user.unit_id)
    @active_employees = Employee.where(active: true)
  end

  # GET /visits/1/edit
  def edit
    @active_units = Unit.where(active: true).or(Unit.where(id: @visit.unit_id))
    @active_sectors = Sector.where(active: true, unit_id: current_user.unit_id).or(Sector.where(id: @visit.sector_id))
    @active_employees = Employee.where(active: true).or(Employee.where(id: @visit.employee_id))
  end

  # POST /visits or /visits.json
  def create
    # @visit = Visit.new(visit_params)
    @visitor = Visitor.find_by(cpf: visit_params[:visitor_attributes][:cpf])
    @visitor ||= Visitor.new(visit_params[:visitor_attributes]) # Cria um novo visitante se não existir

    @visit = Visit.new(visit_params.except(:visitor_attributes)) # Cria a visita sem os atributos do visitante
    @visit.visitor = @visitor

    respond_to do |format|
      if @visit.save
        format.html { redirect_to @visit, notice: "Visit was successfully created." }
        format.json { render :show, status: :created, location: @visit }
      else
        @active_units = Unit.where(active: true)
        @active_sectors = Sector.where(active: true, unit_id: current_user.unit_id)
        @active_employees = Employee.where(active: true)
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visits/1 or /visits/1.json
  def update
    respond_to do |format|
      if @visit.update(visit_params)
        format.html { redirect_to @visit, notice: "Visit was successfully updated." }
        format.json { render :show, status: :ok, location: @visit }
      else
        @active_units = Unit.where(active: true).or(Unit.where(id: @visit.unit_id))
        @active_sectors = Sector.where(active: true, unit_id: current_user.unit_id).or(Sector.where(id: @visit.sector_id))
        @active_employees = Employee.where(active: true).or(Employee.where(id: @visit.employee_id))
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1 or /visits/1.json
  def destroy
    @visit.destroy!

    respond_to do |format|
      format.html { redirect_to visits_path, status: :see_other, notice: "Visit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @active_units = Unit.where(active: true)
    @active_sectors = Sector.where(active: true, unit_id: current_user.unit_id)
    @active_employees = Employee.where(active: true)
    @visitor = Visitor.find_by(cpf: params[:cpf])
    if @visitor
      @visitor_encontrado = true # Indica que o visitante foi encontrado
    else
      @visitor = Visitor.new # Cria um novo visitante se não for encontrado
      @visitor_encontrado = false
    end
    @visit = Visit.new(visitor: @visitor) # Associa o visitante à visita
    render :new # Renderiza a view 'new' novamente com os resultados
  end

  def confirm
    @visit = Visit.find(params[:id])
    authorize! :confirm, @visit # Verifica se o usuário pode confirmar a visita
    @visit.confirm!
    redirect_to visits_path, notice: "Visita confirmada com sucesso."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def visit_params
      params.expect(visit: [ :confirmed_time, :unit_id, :sector_id, :employee_id, visitor_attributes: [ :cpf, :name, :rg, :phone, :photo ] ])
    end
end
