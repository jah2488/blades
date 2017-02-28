class FactionCharacter < ApplicationRecord
  belongs_to :faction
  belongs_to :character
end
