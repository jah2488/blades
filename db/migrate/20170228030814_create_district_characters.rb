class CreateDistrictCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :district_characters do |t|
      t.belongs_to :district, foreign_key: true
      t.belongs_to :character, foreign_key: true

      t.timestamps
    end
  end
end
