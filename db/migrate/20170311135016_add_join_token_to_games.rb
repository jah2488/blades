class AddJoinTokenToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :join_token, :string
  end
end
