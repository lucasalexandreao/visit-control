class AddSectorToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :sector, foreign_key: true
  end
end
