class Sector < ApplicationRecord
  belongs_to :unit
  validates :name, presence: true
  validates :unit_id, presence: true
  has_many :employees, dependent: :destroy
  before_update :deactivate_employees_if_inactive, if: :inactive?
  validate :unit_must_be_active, if: :activating_sector?
  validates :name, presence: true, length: 1..100
  validates :unit_id, presence: true

  # Retorna se está inativo
  def inactive?
    !self.active
  end

  # Desativa
  def deactivate!
    update(active: false)
  end

  # Ativa
  def activate!
    update(active: true)
  end

  # Desativa os funcionários caso o setor seja desativado
  def deactivate_employees_if_inactive
    if self.employees.present?
      ActiveRecord::Base.transaction do
        employees = self.employees
        employees.each do |employee|
          employee.deactivate!
        end
      end
    end
  end

  # Impede de ativar setor associado a uma unidade desativada
  def unit_must_be_active
    if unit && !unit.active
      errors.add(:base, "Não é possível ativar um setor cuja unidade está desativada.")
    end
  end

  # Verifica se o setor foi ativado
  def activating_sector?
    active_changed? && active
  end
end
