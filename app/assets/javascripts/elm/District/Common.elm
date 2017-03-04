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
    }


type Msg
    = NoOp
    | ToggleStats
    | ToggleFactions
    | ToggleDescription
