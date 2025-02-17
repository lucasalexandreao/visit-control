class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_one :employee, dependent: :nullify
  belongs_to :unit, optional: true
  validates :unit_id, presence: true, if: -> { attendant? }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :role, presence: true

  enum :role, { admin: 0, attendant: 1, employee: 2 } # Níveis de acesso (papel)
end
