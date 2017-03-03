module Models exposing (..)


type alias Game =
    { id : Int
    , user_id : Int
    , name : String
    , slug : String
    }


nullGame : Game
nullGame =
    { id = 0, user_id = 0, name = "No Game", slug = "no-game" }


type alias Category =
    { id : Int
    , name : String
    , description : Maybe String
    , slug : String
    }


nullCategory : Category
nullCategory =
    { id = 0, name = "No Category", description = Nothing, slug = "No-Category" }


type alias Faction =
    { id : Int
    , game_id : Int
    , category_id : Maybe Int
    , name : String
    , description : Maybe String
    , reputation : Int
    , hold : Int
    , turf : Int
    , faction_status : Int
    , slug : String
    , game : Game
    , category : Maybe Category
    }


nullFaction : Faction
nullFaction =
    { id = 0
    , game_id = 0
    , category_id = Nothing
    , name = "No Faction"
    , description = Nothing
    , reputation = 0
    , hold = 0
    , turf = 0
    , faction_status = 0
    , slug = "no-faction"
    , game = nullGame
    , category = Nothing
    }


type alias Character =
    {}


type alias District =
    { id : Int
    , game_id : Int
    , name : String
    , description : Maybe String
    , wealth : Int
    , security_and_safety : Int
    , criminal_influence : Int
    , occult_influence : Int
    , slug : String
    , factions : List Faction
    , characters : List Character
    }


nullDistrict : District
nullDistrict =
    { id = 0
    , game_id = 0
    , name = "Unkown District"
    , description = Nothing
    , wealth = 0
    , security_and_safety = 0
    , criminal_influence = 0
    , occult_influence = 0
    , slug = "unknown-district"
    , factions = []
    , characters = []
    }
