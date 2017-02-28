class CreateDistrictFactions < ActiveRecord::Migration[5.0]
  def change
    create_table :district_factions do |t|
      t.belongs_to :district, foreign_key: true
      t.belongs_to :faction, foreign_key: true
      t.boolean :in_control

      t.timestamps
    end
  end
end
