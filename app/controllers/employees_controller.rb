class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /employees or /employees.json
  def index
    @employees = Employee.all

    if params[:sector_id].present?
      @employees = Employee.where(active: true, sector_id: params[:sector_id])
    else
      @employees = []
    end

    render json: @employees.map { |employee| { id: employee.id, name: employee.name } }
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @employee.build_user(role: 2)
    @active_sectors = Sector.where(active: true)
  end

  # GET /employees/1/edit
  def edit
    @active_sectors = Sector.where(active: true).or(Sector.where(id: @employee.sector_id))
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    if @employee.user.nil?
      @employee.build_user  # Se não foi construído corretamente, cria um novo User
    end

    @employee.user.role = 2  # Garante que o usuário é do tipo funcionário


    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        @active_sectors = Sector.where(active: true)
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        @active_sectors = Sector.where(active: true).or(Sector.where(id: @employee.sector_id))
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy!

    respond_to do |format|
      format.html { redirect_to employees_path, status: :see_other, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.expect(employee: [ :cpf, :name, :sector_id, :active, user_attributes: [ :id, :email, :password, :password_confirmation ] ])
    end
end
