class ChangeRoleTypeinUsers < ActiveRecord::Migration[8.0]
  def up
    # Altera o tipo da coluna "role" para integer, especificando a conversão com USING
    change_column :users, :role, 'integer USING CAST(role AS integer)'
  end

  def down
    # Reverte a alteração, convertendo de volta para string (ou o tipo original)
    change_column :users, :role, 'varchar USING CAST(role AS varchar)'
  end
end
