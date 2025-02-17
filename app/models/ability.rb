# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      # Admin gerencia Usuários, Funcionários, Unidades e Setores
      # Optei por permitir o Admin apenas visualizar Visitas e Visitantes
      can :manage, User
      can :manage, Employee
      can :manage, Unit
      can :manage, Sector
      can :read, Visit
      can :read, Visitor
    elsif user.attendant?
      # Atendente gerencia Visitas e Visitantes da sua unidade
      # Não pode confirmar visitas (notificação do funcionário)
      can :manage, Visit, unit_id: user.unit_id
      cannot :confirm, Visit
      can :manage, Visitor
    elsif user.employee?
      # Funcionário apenas vê as visitas em espera, e pode confirmá-las (notificar o sistema)
      employee = user.employee
      can :read, Visit, employee_id: employee.id, confirmed_time: nil
      can :confirm, Visit, employee_id: employee.id, confirmed_time: nil
    end
  end
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
end
