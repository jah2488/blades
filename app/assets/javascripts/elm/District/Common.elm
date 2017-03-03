module District.Common exposing (..)

import Models exposing (..)


type alias Flags =
    { district : District
    }


type alias Model =
    { district : District
    }


type Msg
    = NoOp
