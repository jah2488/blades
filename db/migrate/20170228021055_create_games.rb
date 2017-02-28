class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name, null: false
      t.string :slug

      t.timestamps
    end
  end
end
