class Employee < ApplicationRecord
  belongs_to :sector
  belongs_to :user
  has_many :visits
  accepts_nested_attributes_for :user
end
