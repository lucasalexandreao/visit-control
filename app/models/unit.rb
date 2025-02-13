class Unit < ApplicationRecord
  has_many :sectors, dependent: :destroy
  validates :name, presence: true
end
