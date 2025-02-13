class Visit < ApplicationRecord
  belongs_to :visitor
  belongs_to :unit
  belongs_to :sector
  belongs_to :employee
  accepts_nested_attributes_for :visitor
end
