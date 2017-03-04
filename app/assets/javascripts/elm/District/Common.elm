module District.Common exposing (..)

import Models exposing (..)


type alias Flags =
    { district : District
    }


type alias Model =
    { district : District
    , factionsOpen : Bool
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
    | DescriptionChanged String
    | WealthChanged Int
    | SecurityAndSafetyChanged Int
    | CriminalInfluenceChanged Int
    | OccultInfluenceChanged Int
