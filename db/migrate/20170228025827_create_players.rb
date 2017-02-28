class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.belongs_to :game, foreign_key: true
      t.string :name
      t.text :description
      t.string :playbook
      t.integer :stress
      t.integer :coin

      t.string :slug
      t.timestamps
    end
  end
end
