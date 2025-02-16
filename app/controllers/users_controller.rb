class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @active_units = Unit.where(active: true)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "Usuário criado com sucesso."
    else
      @active_units = Unit.where(active: true)
      render :new
    end
  end

  def edit
    @active_units = Unit.where(active: true)
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "Usuário atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_path, notice: "Usuário excluído com sucesso."
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "Acesso negado." unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.expect(user: [ :email, :password, :password_confirmation, :role, :unit_id ])
  end
end
