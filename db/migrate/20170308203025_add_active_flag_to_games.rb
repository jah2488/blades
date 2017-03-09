class AddActiveFlagToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :active, :bool, default: false
  end
end
