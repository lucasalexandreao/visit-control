class Employee < ApplicationRecord
  belongs_to :sector
  belongs_to :user, dependent: :destroy, optional: true
  has_many :visits
  accepts_nested_attributes_for :user
  before_update :destroy_user_if_inactive
  before_save :create_user_if_activated
  validate :sector_must_be_active, if: :activating_employee?
  validates :cpf, presence: true, uniqueness: true, length: { is: 14 }
  validates :name, presence: true, length: 1..200
  validates :sector_id, presence: true

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

  # Remove usuário de um funcionário desativado
  def destroy_user_if_inactive
    if active_changed? && !active? && user.present?
      user_to_delete = user  # Salva o usuário antes de remover a referência
      update_column(:user_id, nil) # Remove a referência
      user_to_delete.destroy
    end
  end

  # Cria um usuário padrão quando reativa um funcionário
  def create_user_if_activated
    if active_changed? && active? && user.nil?
      generated_email = generate_email
      new_user = User.create(email: generated_email, password: "temporary123", role: 2)
      update_column(:user_id, new_user.id)
    end
  end

  # gera email padrão e evita duplicatas
  def generate_email
    base_email = "tempemail"
    domain = "empresa.com"
    count = User.where("email LIKE ?", "#{base_email}%").count
    count > 0 ? "#{base_email}#{count}@#{domain}" : "#{base_email}@#{domain}"
  end

  # Impede de ativar um funcionário de um setor desativado
  def sector_must_be_active
    if sector && !sector.active
      errors.add(:base, "Não é possível ativar um funcionário cujo setor está desativado.")
    end
  end

  # Verifica se o funcionário foi ativado
  def activating_employee?
    active_changed? && active
  end
end
