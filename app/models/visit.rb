class Visit < ApplicationRecord
  belongs_to :visitor
  belongs_to :unit
  belongs_to :sector
  belongs_to :employee
  accepts_nested_attributes_for :visitor
  validates :sector_id, presence: true
  validates :employee_id, presence: true


  scope :not_confirmed, -> { where(confirmed_time: nil) } # Visitas não confirmadas pelo funcionário

  # Confirmar visita (notificar o sistema)
  def confirm!
    update(confirmed_time: Time.current)
  end
end
