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
