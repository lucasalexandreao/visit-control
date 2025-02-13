class Sector < ApplicationRecord
  belongs_to :unit
  validates :name, presence: true
  validates :unit_id, presence: true
end
