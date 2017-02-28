class CreateFactionCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :faction_characters do |t|
      t.belongs_to :faction, foreign_key: true
      t.belongs_to :character, foreign_key: true
      t.boolean :leader

      t.timestamps
    end
  end
end
