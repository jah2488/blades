class AddCurrentGameIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_game_id, :int
  end
end
