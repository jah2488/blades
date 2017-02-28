class CreateFactions < ActiveRecord::Migration[5.0]
  def change
    create_table :factions do |t|
      t.belongs_to :game, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.integer :reputation, default: 0
      t.integer :hold, default: 0
      t.integer :turf, default: 0
      t.integer :faction_status, default: 0

      t.string :slug
      t.timestamps
    end
  end
end
