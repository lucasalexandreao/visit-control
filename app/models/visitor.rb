class Visitor < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_many :visits
  validates :cpf, presence: true, uniqueness: true
  validates :name, presence: true
  validates :rg, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :photo, presence: true
end
