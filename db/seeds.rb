# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'user@example.com', password: 'password')
game = Game.create(name: 'Blades On The Edge', user: user)

district = District.create(name: 'The Gardens', game: game)
faction = Faction.create(name: 'The Amber Vigil', game: game)
faction2 = Faction.create(name: 'The Sanctuary of Salt', game: game)
faction3 = Faction.create(name: 'Order of the Eternal Forge', game: game)
faction4 = Faction.create(name: 'The Dark Flame', game: game)

DistrictFaction.create!(district: district, faction: faction)

Faction.create(name: 'The Board', game: game)
