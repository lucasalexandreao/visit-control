class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :employee
  validates :email, presence: true, uniqueness: true

  enum :role, { admin: 0, attendant: 1, employee: 2 }
end
