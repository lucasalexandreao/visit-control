class VisitorsController < ApplicationController
  before_action :set_visitor, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /visitors or /visitors.json
  def index
    @visitors = Visitor.all
  end

  # GET /visitors/1 or /visitors/1.json
  def show
  end

  # GET /visitors/new
  def new
    @visitor = Visitor.new
  end

  # GET /visitors/1/edit
  def edit
  end

  # POST /visitors or /visitors.json
  def create
    @visitor = Visitor.new(visitor_params)

    respond_to do |format|
      if @visitor.save
        format.html { redirect_to @visitor, notice: "Visitor was successfully created." }
        format.json { render :show, status: :created, location: @visitor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visitors/1 or /visitors/1.json
  def update
    respond_to do |format|
      if @visitor.update(visitor_params)
        format.html { redirect_to @visitor, notice: "Visitor was successfully updated." }
        format.json { render :show, status: :ok, location: @visitor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @visitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitors/1 or /visitors/1.json
  def destroy
    @visitor.destroy!

    respond_to do |format|
      format.html { redirect_to visitors_path, status: :see_other, notice: "Visitor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @visitor = Visitor.find_by(cpf: params[:cpf])
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visitor
      @visitor = Visitor.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def visitor_params
      params.expect(visitor: [ :cpf, :name, :rg, :phone, :photo ])
    end
end
