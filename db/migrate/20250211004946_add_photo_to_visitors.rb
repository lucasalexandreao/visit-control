class AddPhotoToVisitors < ActiveRecord::Migration[8.0]
  def change
    add_column :visitors, :photo, :string
  end
end
