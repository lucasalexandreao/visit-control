class ChangeUserIdToBeNullableInEmployees < ActiveRecord::Migration[8.0]
  def change
    change_column_null :employees, :user_id, true
  end
end
