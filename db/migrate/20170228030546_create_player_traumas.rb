class CreatePlayerTraumas < ActiveRecord::Migration[5.0]
  def change
    create_table :player_traumas do |t|
      t.belongs_to :player, foreign_key: true
      t.belongs_to :trauma, foreign_key: true

      t.timestamps
    end
  end
end
