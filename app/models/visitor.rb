class Visitor < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_many :visits
  validates :cpf, presence: true, uniqueness: true, length: { is: 14 }
  validates :name, presence: true
  validates :rg, presence: true, uniqueness: true, length: { is: 11 }
  validates :phone, presence: true, length: { is: 16 }
  validates :photo, presence: true
end
