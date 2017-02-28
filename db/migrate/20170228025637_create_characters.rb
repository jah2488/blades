class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.belongs_to :game, foreign_key: true
      t.string :name
      t.text :description

      t.string :slug
      t.timestamps
    end
  end
end
