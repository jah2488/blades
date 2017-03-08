module District.Types exposing (..)

import Models exposing (..)


type alias Flags =
    { district : District
    , allFactions : List Faction
    , csrfToken_ : String
    }


type alias Model =
    { district : District
    , originalDistrict : District
    , factionsOpen : Bool
    , factionIDs : List Int
    , allFactions : List Faction
    , statsOpen : Bool
    , descriptionOpen : Bool
    , editing : Bool
    , editable : Bool
    , csrfToken : String
    }


type EditState
    = Enter
    | Exit
    | Reset
    | Cancel


type ToggleSection
    = Stats
    | Factions
    | Descriptions


type Field
    = Description String
    | Wealth Int
    | SecurityAndSafety Int
    | CriminalInfluence Int
    | OccultInfluence Int


type FactionAction
    = Add Int
    | Remove Int


type Msg
    = NoOp
    | Edit EditState
    | Toggle ToggleSection
    | Changed Field
    | FactionList FactionAction
    | SavedForm Response
