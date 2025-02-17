class Unit < ApplicationRecord
  has_many :sectors, dependent: :destroy
  has_many :users, dependent: :destroy
  before_update :deactivate_sectors_and_attendants_if_inactive, if: :inactive?
  validates :name, presence: true, length: 1..100

  def inactive?
    !self.active
  end

  def deactivate!
    update(active: false)
  end

  def activate!
    update(active: true)
  end

  def deactivate_sectors_and_attendants_if_inactive
    if self.sectors.present?
        ActiveRecord::Base.transaction do
            sectors = self.sectors
            sectors.each do |sector|
                sector.deactivate!
            end
        end
    end
    if self.users.present?
        ActiveRecord::Base.transaction do
            users = self.users
            users.each do |user|
                user.destroy!
            end
        end
    end
  end
end
