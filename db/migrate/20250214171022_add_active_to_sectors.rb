class AddActiveToSectors < ActiveRecord::Migration[8.0]
  def change
    add_column :sectors, :active, :boolean, default: true
  end
end
