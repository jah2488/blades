module District.Common exposing (..)

import Models exposing (..)


type alias Flags =
    { district : District
    , allFactions : List Faction
    }


type alias Model =
    { district : District
    , factionsOpen : Bool
    , factionIDs : List Int
    , allFactions : List Faction
    , statsOpen : Bool
    , descriptionOpen : Bool
    , editing : Bool
    , editable : Bool
    }


type Msg
    = NoOp
    | EnterEdit
    | ExitEdit
    | ToggleStats
    | ToggleFactions
    | ToggleDescription
    | FactionAdded Int
    | FactionRemoved Int
    | DescriptionChanged String
    | WealthChanged Int
    | SecurityAndSafetyChanged Int
    | CriminalInfluenceChanged Int
    | OccultInfluenceChanged Int
