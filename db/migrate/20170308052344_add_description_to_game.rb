class AddDescriptionToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :description, :text
  end
end
