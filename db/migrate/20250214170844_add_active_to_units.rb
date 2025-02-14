class AddActiveToUnits < ActiveRecord::Migration[8.0]
  def change
    add_column :units, :active, :boolean, default: true
  end
end
