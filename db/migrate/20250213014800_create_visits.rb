class CreateVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :visits do |t|
      t.datetime :confirmed_time
      t.references :visitor, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.references :sector, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
