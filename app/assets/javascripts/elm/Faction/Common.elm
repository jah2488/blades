module Faction.Common exposing (..)

import Http
import Maybe
import Models exposing (..)


type alias Flags =
    { faction : Faction
    , expanded : Bool
    , editable : Bool
    , csrfToken : String
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
    | EnterEdit
    | ExitEdit
    | HoldChanged Bool
    | RepChanged String
    | StatusChanged String
    | DescriptionChanged String
    | SavedForm (Result Http.Error String)
