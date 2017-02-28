class District < ApplicationRecord
  belongs_to :game

  has_many :district_factions
  has_many :factions, through: :district_factions

  has_many :district_characters
  has_many :characters, through: :district_characters
end
