class Employee < ApplicationRecord
  belongs_to :sector
  belongs_to :user, dependent: :destroy, optional: true
  has_many :visits
  accepts_nested_attributes_for :user
  before_update :destroy_user_if_inactive
  before_save :create_user_if_activated
  validate :sector_must_be_active, if: :activating_employee?

  def inactive?
    !self.active
  end

  def deactivate!
    update(active: false)
  end

  def activate!
    update(active: true)
  end

  def destroy_user_if_inactive
    if active_changed? && !active? && user.present?
      user_to_delete = user  # Salva o usuário antes de remover a referência
      update_column(:user_id, nil) # Remove a referência
      user_to_delete.destroy
    end
  end

  def create_user_if_activated
    if active_changed? && active? && user.nil?
      generated_email = generate_email
      new_user = User.create(email: generated_email, password: "temporary123", role: 2)
      update_column(:user_id, new_user.id)
    end
  end

  def generate_email
    base_email = name.downcase.gsub(/\s+/, "_")
    domain = "empresa.com"
    count = User.where("email LIKE ?", "#{base_email}%").count
    count > 0 ? "#{base_email}_#{count}@#{domain}" : "#{base_email}@#{domain}"
  end

  def sector_must_be_active
    if sector && !sector.active
      errors.add(:base, "Não é possível ativar um funcionário cujo setor está desativado.")
    end
  end

  def activating_employee?
    active_changed? && active
  end
end
