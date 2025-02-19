class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :edit, :update, :destroy ]
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new

    # Filtra unidades ativas
    @active_units = Unit.where(active: true)
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "Usuário cadastrado com sucesso." }
        format.json { render :show, status: :created, location: @user }
      else
        @active_units = Unit.where(active: true)
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    # Filtra unidades ativas ou associadas ao usuário
    @active_units = Unit.where(active: true).or(Unit.where(id: @user.unit_id))
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "Usuário atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @user }
      else
        @active_units = Unit.where(active: true).or(Unit.where(id: @user.unit_id))
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_path, notice: "Usuário excluído com sucesso."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.expect(user: [ :email, :password, :password_confirmation, :role, :unit_id ])
  end
end
