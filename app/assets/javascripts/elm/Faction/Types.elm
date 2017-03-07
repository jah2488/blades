module Faction.Types exposing (..)

import Http
import Models exposing (..)


type alias Flags =
    { faction : Faction
    , expanded : Bool
    , editable : Bool
    , csrfToken_ : String
    }


type alias Model =
    { faction : Faction
    , expanded : Bool
    , editable : Bool
    , editMode : Bool
    , csrfToken : String
    }


nullModel : Model
nullModel =
    { faction = nullFaction
    , expanded = False
    , editMode = False
    , editable = True
    , csrfToken = ""
    }


type Msg
    = ShowTools
    | NoOp
    | EnterEdit
    | ExitEdit
    | CancelEdit
    | HoldChanged Bool
    | RepChanged String
    | StatusChanged String
    | DescriptionChanged String
    | SavedForm (Result Http.Error String)
