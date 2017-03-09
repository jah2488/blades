class UserPlayer < ApplicationRecord
  belongs_to :user
  belongs_to :player
end
