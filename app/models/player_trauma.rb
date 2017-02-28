class PlayerTrauma < ApplicationRecord
  belongs_to :player
  belongs_to :trauma
end
