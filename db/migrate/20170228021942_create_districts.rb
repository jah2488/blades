class CreateDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :districts do |t|
      t.belongs_to :game, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.integer :wealth, default: 0
      t.integer :security_and_safety, default: 0
      t.integer :criminal_influence, default: 0
      t.integer :occult_influence, default: 0

      t.string :slug

      t.timestamps
    end
  end
end
