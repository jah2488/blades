module District.Common exposing (..)

import Models exposing (..)


type alias Flags =
    { district : District
    , allFactions : List Faction
    , csrfToken_ : String
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
    , csrfToken : String
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
    | SavedForm Response
